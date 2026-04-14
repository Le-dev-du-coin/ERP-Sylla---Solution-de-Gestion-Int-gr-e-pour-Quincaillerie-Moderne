from __future__ import annotations

from typing import TYPE_CHECKING

from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
from django.views.generic import DetailView, ListView, CreateView, UpdateView
from django.views.generic.base import RedirectView
from erp_sylla.apps.core.permissions import GerantRequiredMixin
from django.urls import reverse_lazy

from erp_sylla.users.models import User

if TYPE_CHECKING:
    from django.db.models import QuerySet


class AgentListView(GerantRequiredMixin, ListView):
    model = User
    template_name = "users/agent_list.html"
    context_object_name = "agents"

    def get_queryset(self):
        return User.objects.exclude(is_superuser=True).order_by("username")


class AgentCreateView(GerantRequiredMixin, CreateView):
    model = User
    fields = ["username", "name", "email", "password", "role", "assigned_warehouse"]
    template_name = "users/agent_form.html"
    success_url = reverse_lazy("users:agent-list")

    def form_valid(self, form):
        # On hash le mot de passe avant de sauver
        user = form.save(commit=False)
        user.set_password(form.cleaned_data["password"])
        user.save()
        return super().form_valid(form)

    def get_form(self, form_class=None):
        form = super().get_form(form_class)
        for field in form.fields.values():
            field.widget.attrs.update({"class": "form-control rounded-3"})
        return form


class AgentUpdateView(GerantRequiredMixin, UpdateView):
    model = User
    fields = ["username", "name", "email", "role", "assigned_warehouse", "is_active"]
    template_name = "users/agent_form.html"
    success_url = reverse_lazy("users:agent-list")

    def get_form(self, form_class=None):
        form = super().get_form(form_class)
        form.fields["username"].disabled = True
        for field in form.fields.values():
            field.widget.attrs.update({"class": "form-control rounded-3"})
        return form



class UserDetailView(LoginRequiredMixin, DetailView):
    model = User
    slug_field = "username"
    slug_url_kwarg = "username"


user_detail_view = UserDetailView.as_view()


class UserUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    model = User
    fields = ["name"]
    success_message = _("Information successfully updated")

    def get_success_url(self) -> str:
        assert self.request.user.is_authenticated  # type guard
        return self.request.user.get_absolute_url()

    def get_object(self, queryset: QuerySet | None = None) -> User:
        assert self.request.user.is_authenticated  # type guard
        return self.request.user


user_update_view = UserUpdateView.as_view()


class UserRedirectView(LoginRequiredMixin, RedirectView):
    permanent = False

    def get_redirect_url(self):
        user = self.request.user
        if user.role == "GERANT" or user.is_superuser:
            return reverse("core:finance")
        return reverse("core:pos")


user_redirect_view = UserRedirectView.as_view()
