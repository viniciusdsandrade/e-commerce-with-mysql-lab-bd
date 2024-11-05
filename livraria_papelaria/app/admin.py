from django.contrib import admin
from django.apps import apps

# Register your models here.

# Get all models from the app
app_models = apps.get_app_config('app').get_models()

# Register each model in the admin
for model in app_models:
    try:
        admin.site.register(model)
    except admin.sites.AlreadyRegistered:
        pass  # If it's already registered, skip it