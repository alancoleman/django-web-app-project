from django import forms

# This class will extend the Django forms.Form class
class ContactForm(forms.Form):
    name = forms.CharField(
        required=True,
        # Specifies the front end widget
        widget=forms.TextInput(attrs={"class": "form-control", "placeholder": "Name"}),
    )
    email = forms.EmailField(
        required=True,
        widget=forms.TextInput(attrs={"class": "form-control", "placeholder": "Email"}),
    )
    message = forms.CharField(
        required=True,
        widget=forms.Textarea(
            attrs={"class": "form-control", "placeholder": "Message", "rows": 5}
        ),
    )
