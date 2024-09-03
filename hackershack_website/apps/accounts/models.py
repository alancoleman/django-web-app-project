from django.db import models
# Import the user auth model to reference the user
from django.contrib.auth.models import User


class UserInterest(models.Model):
    name = models.CharField(max_length=64, unique=True)
    normalized_name = models.CharField(max_length=64, unique=True)

    def __str__(self):
        return self.name


class UserPersona(models.Model):
    name = models.CharField(max_length=64, unique=True)
    normalized_name = models.CharField(max_length=64, unique=True)
    description = models.CharField(max_length=200)

    def __str__(self):
        return self.name


class UserProfile(models.Model):
    # owner
    # Note n_delete=models.CASCADE here, this means that if the user is deleted then that deletion will cascade down to the user profile in a one to one manner.
    # related_name="profile" means that the profile can be accessed through the user object - request.user.profile
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")

    # settings
    is_full_name_displayed = models.BooleanField(default=True)

    # details
    bio = models.CharField(max_length=500, blank=True, null=True)
    website = models.URLField(max_length=200, blank=True, null=True)
    persona = models.ForeignKey(
        UserPersona, on_delete=models.SET_NULL, blank=True, null=True
    )
    # No null=True in a many to many relationship
    interests = models.ManyToManyField(UserInterest, blank=True)