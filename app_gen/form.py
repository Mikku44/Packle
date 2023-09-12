from django import forms

class addItem(forms.Form):
    name = forms.CharField(max_length=255,required=True,label="Name ")
    # Email = forms.EmailField(max_length=255,required=True,label="Email ")



class registerUser(forms.Form):
    email = forms.EmailField(max_length=255,required=True,label="Email ")
    password  = forms.CharField(max_length=255,required=True,label="Password",widget=forms.PasswordInput())
    password2  = forms.CharField(max_length=255,required=True,label="Password",widget=forms.PasswordInput())
    
class loginForm(forms.Form):
    email  = forms.CharField(max_length=255,required=True,label="Email")
    password = forms.CharField(max_length=255,required=True,label="Password")


class CreditForm(forms.Form):
    creditNo = forms.CharField(max_length=16,required=True,label="Credit Card infomation")
    