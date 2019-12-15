from django.shortcuts import render
import re
from datetime import datetime
from django.http import HttpResponse

# Create your views here.
print("http://127.0.0.1:8000/hello/VSCode")

def home(request):
    return render(request, 'hello/home.html')
    # return HttpResponse("Hello, Django!")

def about(request):
    return render(request, 'hello/about.html')

def contact(request):
    return render(request, 'hello/contact.html')



# def hello_there(request, name):
#     now = datetime.now()
#     formatted_now = now.strftime("%A, %d %b, %Y at %X")

#     # Filter the name argument to letters only using regular expressions. URL arguments
#     # can contain arbitrary text, so we restrict to safe characters only.
#     match_object = re.match("[a-zA-Z]+", name)

#     if match_object:
#         clean_name = match_object.group(0)
#     else:
#         clean_name = "Friend"

#     content = "Hello there, " + clean_name + "!<br> It's " + formatted_now
#     return HttpResponse(content)

def hello_there(request, name):
    return render(
        request,
        'hello/hello_there.html',
        {
            'name': name,
            'date': datetime.now()
        }
    )