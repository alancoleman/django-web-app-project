import bleach
from django.shortcuts import render
from django.http import HttpRequest, HttpResponse
from django.core.mail import send_mail

# Import the website settings to be able to access the email settings further down
from hackershack_website import settings

from .forms import ContactForm

def contact(request: HttpRequest) -> HttpResponse:
    if request.method == "GET":
        form = ContactForm()
    elif request.method == "POST":
        form = ContactForm(request.POST)

        if form.is_valid():
            name = bleach.clean(form.cleaned_data["name"])
            email = bleach.clean(form.cleaned_data["email"])
            message = bleach.clean(form.cleaned_data["message"])

            send_mail(
                f"{name} sent an email", message, email, [settings.DEFAULT_FROM_EMAIL]
            )

            # Use a new form to clean out the old data and render a success message
            return render(
                request, "contact.html", {"form": ContactForm(), "success": True}
            )
    else:
        raise NotImplementedError

    return render(request, "contact.html", {"form": form})
