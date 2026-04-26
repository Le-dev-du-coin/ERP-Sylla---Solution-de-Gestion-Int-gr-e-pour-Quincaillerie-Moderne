from django.urls import path
from .views import SecurePDFDownloadView, NotificationDashboardView, SecureReportDownloadView, CommunicationConfigUpdateView

app_name = "communications"

urlpatterns = [
    path("download/<uuid:token>/", SecurePDFDownloadView.as_view(), name="secure-pdf-download"),
    path("report/<uuid:token>/", SecureReportDownloadView.as_view(), name="report-download"),
    path("dashboard/", NotificationDashboardView.as_view(), name="notification-dashboard"),
    path("settings/", CommunicationConfigUpdateView.as_view(), name="config-update"),
]
