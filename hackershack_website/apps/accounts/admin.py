# Here, models can be imported and registered for use with the Django admin interface.
from django.contrib import admin

# Import models
from .models import UserProfile, UserPersona, UserInterest

# Register models
admin.site.register(UserProfile)
admin.site.register(UserPersona)
admin.site.register(UserInterest)