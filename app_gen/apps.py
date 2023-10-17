from django.apps import AppConfig
from django.contrib.admin.apps import AdminConfig

class AppGenConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'app_gen'
class MyAdminConfig(AdminConfig):
    default_site = 'app_gen.admin.MyAdminSite'