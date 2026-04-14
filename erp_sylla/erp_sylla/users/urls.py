from django.urls import path

from .views import (
    user_detail_view, user_redirect_view, user_update_view,
    AgentListView, AgentCreateView, AgentUpdateView
)

app_name = "users"
urlpatterns = [
    path("~redirect/", view=user_redirect_view, name="redirect"),
    path("~update/", view=user_update_view, name="update"),
    path("agents/", view=AgentListView.as_view(), name="agent-list"),
    path("agents/add/", view=AgentCreateView.as_view(), name="agent-add"),
    path("agents/<int:pk>/edit/", view=AgentUpdateView.as_view(), name="agent-edit"),
    path("<str:username>/", view=user_detail_view, name="detail"),
]
