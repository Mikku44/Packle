from django.shortcuts import redirect, render
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.http.response import HttpResponse
from django.db import connection
from app_gen.models import *
from .form import addItem,registerUser,loginForm
import random
from hashlib import md5
from datetime import datetime
from django.utils import timezone
import regex
from django.core.mail import send_mail
import os
# send_mail(
#     "Subject here",
#     "Here is the message.",
#     "from@example.com",
#     ["to@example.com"],
#     fail_silently=False,
# )

username = ""
pic = ""


def conn(sql):
    conn = connection.cursor()
    conn.execute(sql)
    return conn.fetchall()
    


def add_month():
        current = datetime.now()

        month = current.month + 1
        if month > 12:
            return current.replace(year=current.year+1,month=1)
        
        return current.replace(month=month)
# Create your views here.
# def admin(request):
#     return render(request,'admin/app_gen/change_form.html')
def home(request):
    
    logined  = loginCheck(request)
    context = {}
    if logined:
      
        context = {'logined':logined}
    print(request.path)
    return render(request,'app_gen/index.html',context)

def logout(request):
    request.session.flush()
    return  HttpResponseRedirect('/')
def forgot(request):
    if loginCheck(request):
        return HttpResponseRedirect(reverse('home'))
    if('resend' in request.GET):
         del request.session['otp'] 
    if('action' in request.GET):
        if (request.session['errorMSG'] != None):
            del request.session['errorMSG'] 
    if(request.method == 'POST'):
        if('verify' in request.POST):
            otp = request.POST['p1'] + request.POST['p2'] + request.POST['p3'] + request.POST['p4']
            if(otp == request.session['otp']):
                request.session['otp'] = "changePass"
                print('corrent')
            else:
               request.session['errorMSG'] = 'Invalid otp'

            return render(request,'app_gen/forgotpasst.html')
        if ('change' in request.POST):
            user = User.objects.get(userEmail=request.session['email'])
            if(request.POST['password'] == request.POST['password2']):
                user.hash_pass = md5(request.POST['password'].encode()).hexdigest()
                user.save()
                request.session['errorMSG'] = 'Password has been changed successfully.'
                del request.session['otp']
                return redirect('login')
            else:
                 request.session['errorMSG'] = 'Something was wrong.'
            return render(request,'app_gen/forgotpasst.html')
        if('send' in request.POST):
            try:
                user = User.objects.get(userEmail=request.POST['email'])
                request.session['email']  = request.POST['email']
                request.session['otp'] = user.hash_pass[0:4]
                print(user.hash_pass[0:4])
            except:
                request.session['errorMSG'] = 'Invalid Email Address.'
    return render(request,'app_gen/forgotpasst.html')
def login(request):
    error = False
    if ('action' in request.GET):
        if(request.GET['action'] == 'remove'):
            del request.session['errorMSG']
    
    response = render(request,'app_gen/login.html',context={'error':error,})
    print(request.COOKIES)

    previous = '/generator'
    if 'previous' in request.GET:
        previous = request.GET['previous']
       
    print(previous)
   

    if loginCheck(request):
        return HttpResponseRedirect(reverse('profile'))
    
    if request.method == 'POST':
        form = loginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            password = md5(form.cleaned_data['password'].encode()).hexdigest()

            print("email : " + email ,"password : " + password)
           
            try :
                print("success")
                data = User.objects.get(userEmail=email,hash_pass=password)
                data.lastLogin = datetime.now()
                data.save()

                request.session['logined'] = True
                request.session['uid'] = data.id
                request.session['username'] = data.name
                request.session['email']  = email
                request.session['pic']  = data.pic
                request.session['role']  = str(data.classUser)
                request.session['status']  = data.status
                request.session['genStep']  = '0'
                request.session['prompt'] = {'0':'mdjrny-v4 style'}
                
               
                return redirect(previous)
                
                
            except :
                print('error')
                error = True 
                request.session['error'] = "Your Email or Password was wrong."
                response = render(request,'app_gen/login.html',context={'error':error,})
            
    return response
        

def register(request):
    error = False
    if request.method == 'POST':
        form = registerUser(request.POST)
        if form.is_valid():
            data = User()
           
            from re import findall
            
            if form.cleaned_data['password'] == form.cleaned_data['password2']:
                try:
                    User.objects.get(userEmail=form.cleaned_data['email'])
                    error = True
                    request.session['error'] = 'This email already exist in own system.'
                except:
                     #hash password into md5
                    pass_hash = md5(form.cleaned_data['password'].encode()).hexdigest()


                    #create data
                    data.name = findall(".+(?=@)",form.cleaned_data['email'])[0]
                    data.note = "This is my packa profile"
                    data.userEmail = form.cleaned_data['email']
                    data.hash_pass = pass_hash
                    data.status = False
                    data.pic = "https://images.unsplash.com/photo-1635614017406-7c192d832072?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"
                    data.regAt = datetime.now()
                    data.lastLogin = datetime.now()
                    data.classUser = Class.objects.get(class_id=1)

                    #collect password into database
                    data.save()
                    print(form.cleaned_data)


                    acc = User.objects.get(userEmail=form.cleaned_data['email'])
                    notfi = Notification()
                    notfi.acc_id = acc
                    notfi.notice_title = 'ยินดีต้อนรับสมาชิกใหม่'
                    notfi.notice_date = datetime.now()
                    notfi.pic_source = 'https://media.istockphoto.com/id/1170730064/vector/customer-review-rating-different-people-give-review-rating-and-feedback-customer-choice-know.jpg?s=612x612&w=0&k=20&c=C56QmdHyDWO8j-S2Medh6akaIuThmaxuSWnr8i_madc='
                    notfi.notice_detail = '''
"ขอต้อนรับท่านเข้าสู่ครอบครัวของเรา! เราขอขอบคุณที่ท่านเลือกเป็นลูกค้าของเราและยินดีที่จะมีโอกาสที่จะบริการท่านทุกวันนี้และในอนาคตที่ยาวนาน

เรามุ่งมั่นที่จะให้บริการท่านด้วยคุณภาพที่ดีที่สุด และทำให้ท่านรู้สึกพิเศษทุกครั้งที่ท่านมาถึงที่นี่. หากท่านมีคำถามหรือข้อเสนอแนะใด ๆ เกี่ยวกับผลิตภัณฑ์หรือบริการของเรา โปรดอย่าลังเลที่จะติดต่อเรา ทีมงานของเราพร้อมรับฟังและช่วยเสมอ

ขอขอบคุณอีกครั้งที่ท่านมาเป็นส่วนหนึ่งของครอบครัวของเรา และเราหวังว่าท่านจะมีประสบการณ์ที่ยอดเยี่ยมกับเราทุกครั้งที่ท่านมาถึงที่นี่

ขอให้ท่านมีวันที่สดใสและอิ่มอร่อยกับผลิตภัณฑ์และบริการของเรา! ขอบคุณอีกครั้งที่ท่านมาเป็นส่วนหนึ่งของทีมของเรา."
'''
                    notfi.save()
                    #for login
                    # data = User.objects.get(userEmail=form.cleaned_data['email'],hash_pass=pass_hash)
                    # data.lastLogin = datetime.now()
                    # data.save()

                    # request.session['logined'] = True
                    # request.session['username'] = data.name
                    # request.session['email']  = form.cleaned_data['email']
                    # request.session['pic']  = data.pic
                    # request.session['role']  = data.classUser.class_name
                    # request.session['status']  = data.status
                    # request.session['genStep']  = '0'
                    # request.session['prompt'] = {'0':'pattern'}

                    try:
                        path = os.path.join(f'./app_gen/static/app_gen/imgGen/',str(acc.id))
                        os.mkdir(path)
                    except:
                        print("can't create directory.")
                        pass
                    return login(request)

            
        
    return render(request,'app_gen/register.html',context={'error':error})

def market(request):
    classes = Class.objects.all()
    logined  = loginCheck(request)
    context = {}
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic,'classes': classes}
    else:
        context = {'classes': classes}
    if request.method == 'POST':
        selected = request.POST['plan']
        
        print(selected)
    
    return render(request,'app_gen/market.html',context)

def transection(request):
    print(loginCheck(request))
    if(loginCheck(request)):
        card = CreditCard.objects.filter(acc=request.session['uid'])
        
        if request.method == 'POST':
            clss = Class.objects.get(class_name=request.POST['plan'])
            request.session['cost'] = clss.class_price
            request.session['classID'] = clss.class_id
            return render(request,'app_gen/transection.html',context={'price':str(clss.class_price),'card':card})
        else:
            return HttpResponseRedirect(reverse('market'))
       
    else:
        request.session['errorMSG'] = "Please Login to upgrade the plan"
        return redirect('login')
        
def collect_card(request):

    user = User.objects.get(id=request.session['uid'])
    classObj = Class.objects.get(class_id=request.session['classID'])
    if request.POST['submit'] == 'collectCard':
        card = CreditCard()
        card.acc = user
        card.creditNum = request.POST['cardinfo']
        card.creditName = request.POST['Cname']
        card.address = request.POST['addr'] +' '+ request.POST['addr2'] +' '+ request.POST['addr3'] +' '+ request.POST['addr4'] +' '+ request.POST['addr5']
        card.CVC = request.POST['cardinfo3']
        card.DDVV = request.POST['cardinfo2']
        card.save()

    transection = Transaction()
    transection.acc_id = user
    if request.POST['submit']  != 'later':
        transection.purchase_date = datetime.now()
        transection.status = True
   
    transection.start_date = datetime.now()
    transection.duedate = add_month()
    transection.total_amount = int(request.session['cost'])
    transection.save()

    user.classUser = classObj
    user.save()

    request.session["role"] =  str(classObj)
    return redirect('product')

def transectionID(request,id):
    
    if request.method == 'POST':
        # print(request.POST['payment'])
        if request.POST['payment'] == 'ID':
            card = CreditCard.objects.filter(acc=request.session['uid'])
            
            clss = Class.objects.get(class_name=request.POST['plan'])
            request.session['cost'] = clss.class_price
            request.session['classID'] = clss.class_id
            return render(request,'app_gen/transection.html',context={'price':str(clss.class_price),'card':card,'id':id})
            
        else:
            # return HttpResponse(request,"hello")
            user = User.objects.get(id=request.session['uid'])
            classObj = Class.objects.get(class_name=request.POST['plan'])
            if request.POST['submit'] == 'collectCard':
                card = CreditCard()
                card.acc = user
                card.creditNum = request.POST['cardinfo']
                card.creditName = request.POST['Cname']
                card.address = request.POST['addr'] +' '+ request.POST['addr2'] +' '+ request.POST['addr3'] +' '+ request.POST['addr4'] +' '+ request.POST['addr5']
                card.CVC = request.POST['cardinfo3']
                card.DDVV = request.POST['cardinfo2']
                card.save()

            transection = Transaction.objects.get(upgrade_id=id)
            if request.POST['submit']  != 'later':
                transection.purchase_date = datetime.now()
                transection.status = True
        
            transection.save()

            user.classUser = classObj
            user.save()

            request.session["role"] =  str(classObj)
            return redirect('payment')
    return redirect('payment')
    
def product(request):
    if ('action' in request.GET):
        if(request.GET['action'] == 'remove'):
            del request.session['errorMSG']

    logined  = loginCheck(request)
    context = {}
    # image = sorted(ImgGen.objects.all(), key=lambda x: random.random())

    users = User.objects.all()
    image = sorted(DetailImgGen.objects.filter(gen_isPublic=True,isRemove=False), key=lambda x: random.random())
    x = [[],[],[],[]]
    counter = 0
    ListOfUsers = []

    for user in users:
        ListOfUsers.append(user.name.replace(" ", ""))
    for img in image:
        n = counter % 4
        
        x[n].append(img)
        counter  += 1
    
    popular = DetailImgGen.objects.filter(gen_isPublic=True,isRemove=False).order_by('-gen_star').first()
    print(popular)

    # print(f"Popular : {popular}")
    # print(f"First : {x[0]}")
    # print(f"Second : {x[1]}")
    # print(f"Third : {x[2]}")
    # print(f"Forth : {x[3]}")

    # ListOfUsers = ["asd",'ojef','alskdfj']
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'username':username,'pic':pic,'sec':x[0],'ssec':x[1],'tsec':x[2],'fosec':x[3],'most':popular,'ListOfUsers':ListOfUsers}
    context = {'sec':x[0],'ssec':x[1],'tsec':x[2],'fosec':x[3],'most':popular,'ListOfUsers':ListOfUsers}
    
    return render(request,'app_gen/product.html',context)

def faq(request):
    if('remove' in request.GET):
        try:
            card = CreditCard.objects.get(id=request.GET['remove'])
            card.delete()
            request.session['msg'] = 'Credit card has deleted successfully'
        except:
            request.session['msg'] = 'Something was wrong!'

    if('action' in request.GET):
         del request.session['msg']
            

    if(request.method == 'POST'):
        
        if(request.POST['submit'] == 'add'):
            address =  request.POST['addr'] +' '+ request.POST['addr2'] +' '+ request.POST['addr3'] +' '+ request.POST['addr4'] +' '+ request.POST['addr5']
            card = CreditCard()
            card.acc = User.objects.get(id=request.session['uid'])
            card.creditName = request.POST['creditName']
            card.creditNum = request.POST['creditNum'].replace(' ', '')
            card.CVC = request.POST['cvc']
            card.DDVV = request.POST['ddvv']
            card.address = address
            card.save()
        elif(request.POST['submit'] == 'update'):
            card = CreditCard.objects.get(id=request.POST['id'])
            card.acc = User.objects.get(id=request.session['uid'])
            card.creditName = request.POST['creditName']
            card.creditNum = request.POST['creditNum']
            card.CVC = request.POST['cvc']
            card.DDVV = request.POST['ddvv']
            card.address = request.POST['addr']
            card.save()


    logined  = loginCheck(request)
    context = {}
    cards = CreditCard.objects.filter(acc_id=request.session['uid'])
    print(cards)
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic,'cards':cards,'notices':NoticesCheck(request)}
    return render(request,'app_gen/FAQ.html',context)

def features(request):
    logined  = loginCheck(request)
    context = {}
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic}
    return render(request,'app_gen/features.html',context)

def company(request):
    logined  = loginCheck(request)
    context = {}
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic}
    return render(request,'app_gen/company.html',context)

def generator(request):
    logined = loginCheck(request)
    
    # request.session['genStep'] = '4'
    if(not logined):
        request.session['errorMSG'] = 'Please login to use Live demo.'
        return HttpResponseRedirect(reverse('login'))
    billCheck(request)
    file = "hello"
    submit = '0'
    brand = ''
    logo = None
    pos = None
    text = None
    
    imgmin = Class.objects.get(class_name=request.session['role']).max_gen_per_date  - len(ImgGen.objects.filter(acc_id=request.session['uid'],gen_CreateAt__gt=datetime(datetime.now().year,datetime.now().month,datetime.now().day)))

    print(request.session['genStep'])
    # print(request.session['prompt'])
    if 'genStep' not in request.session:
        request.session['genStep'] = str(0)
        request.session['prompt'] = {'0':''}
       
        # request.session['prompt'] = {'0':'mdjrny-v4-style box '}
    else:
        if request.session['genStep'] == '0':
            request.session['prompt'] = {'0':' '}
            # request.session['prompt'] = {'0':'mdjrny-v4-style box '}


    
    if request.method == 'POST':             
        request.session['genStep'] = request.POST.get('submit')
        request.session['prompt'][request.session['genStep']]  = request.POST.get('brand')
        
        if(request.POST.get('width') is not None and request.session['genStep'] == '3'):
         

            request.session['prompt'] ['descript'] = request.POST.get('prompt')
            request.session['prompt'][request.session['genStep']]  = f" {request.POST.get('prompt')} {request.POST.get('width')} {request.POST.get('height')} {request.POST.get('long')} {request.POST.get('unit')}"
            print(request.session['prompt']['0'],request.session['prompt']['1'])
            print(request.session['prompt'])
        elif (request.session['genStep'] == '4'):
            
            #add picture here
            if ('text' in request.POST):
                request.session['text'] = request.POST['text']
            if ('logo' in request.FILES):
                logo = request.FILES['logo']
                if logo.name:
                    fn = f"./app_gen/static/app_gen/imgGen/{str(request.session['uid'])}/logo.png"
                    request.session['logo'] = fn
                    request.session['logoposition'] = request.POST['logoPos']
                    open(fn, 'wb').write(logo.file.read())
            else:
                if "logo" in request.session:
                    del request.session['logo']
                    del request.session['logoposition']
                pass

            request.session['genStep'] = '4'
            date = datetime.now()
            date = date.strftime("%d%m%y")
            prompt = request.session['prompt']['0'] + ' '+request.session['prompt']['1'] + ' ' + 'for ' + request.session['prompt'] ['descript']
            filename = prompt[16:26].replace(" ", "") + datetime.now().strftime("%H%M%S")
            user_id = request.session['uid']
            print(filename)
            file = f'/static/app_gen/imgGen/{user_id}/{date}/{filename}.png'
            from os import system
            
            request.session['fileGen'] = file
            user_id = request.session['uid']
            prompt = request.session['prompt']['0'] + ' '+request.session['prompt']['1'] + ' ' + request.session['prompt']['descript']

            mockup_style = request.session['prompt']['2']

          
            # system(f'start "" python -c "import os;from app_gen.StableDiff import *;print(\'startGen\');genImg(\''+str(user_id)+'\',\''+str(prompt)+'\');os.system(\'pause\');"')
            # system(f'start "" python -c "import os;from app_gen.withAPI import *;print(\'startGen\');save_image(\'{str(user_id)}\',\'{str(prompt)}\',\'{filename}\',\'{mockup_style}\');os.system(\'pause\');"')
            # import app_gen.withAPI as gen
            if "logo" in request.session:
                logo =  request.session['logo']
                pos =  request.session['logoposition']
                # gen.save_image(str(user_id),str(prompt),filename,mockup_style,logo,pos)
            if "text" in request.session:
                text = request.session["text"]
                
            system(f'start "" python -c "import os;from app_gen.withAPI import *;print(\'startGen\');save_image(\'{str(user_id)}\',\'{str(prompt)}\',\'{filename}\',\'{mockup_style}\',\'{logo}\',\'{pos}\',\'{text}\');os.system(\'pause\');"')

            request.session['genStep'] = '4'
            #  del request.session['prompt']
             
            print("done")
            return render(request,'app_gen/imgGen.html',{'file':file.replace('.png',' 4.png')})  
            #  return redirect('complete')
             
    context = {'submit' :submit,'brand': brand,'min':int(imgmin)}
    
    

    # print(request.session['genStep'])
    # print(type(request.session['genStep']))
    # print(request.session['prompt'])
    
       
    if request.session['genStep'] == '2':
        if request.session['prompt']['2'] == 'FB':
            context['w'] = '12'
            context['h'] = '14'
            context['d'] = '3'
        elif request.session['prompt']['2'] == 'TB':
            context['w'] = '4'
            context['h'] = '4'
            context['d'] = '12'
        elif request.session['prompt']['2'] == 'MLB':
            context['w'] = '8'
            context['h'] = '11'
            context['d'] = '6'
        elif request.session['prompt']['2'] == 'SB':
            context['w'] = '12'
            context['h'] = '12'
            context['d'] = '12'
    response = render(request,'app_gen/imgGen.html',context)    

    return response

def complete_gen(request):

    addOn = [' 1',' 2',' 3',' 4']
    date = datetime.now()
    date = date.strftime("%d%m%y")
    prompt = request.session['prompt']['0'] + ' '+request.session['prompt']['1'] + ' ' + request.session['prompt'] ['descript']
    filename = prompt[:]

    
    request.session['genStep'] = '0'
    if request.method == 'POST':
        import os
        
        file =  request.POST['packaging']

        img = ImgGen()
        img.acc_id = User.objects.get(id=request.session['uid'])
        img.gen_source = file
        img.gen_CreateAt = datetime.now()
        img.save()


        detail = DetailImgGen()
        detail.gen = img
        detail.gen_message = filename
        detail.gen_isPublic = True
        detail.save()
        try:
            for item in request.session['files_path']:
                path =  request.session['files_path'][item]
                # print(path)
                if path != file:
                    if path != (request.session['files_path']['0']):
                        fullPath = f"{os.getcwd()}/app_gen/{path[1:]}"
                        print(fullPath)
                        os.remove(f"{fullPath}")
                        os.remove(f"{fullPath.replace('.png', '_mockup.png')}")
        except:
            pass
        # os.remove('D:\\anda/app_gen/static/app_gen/imgGen/1/261023/goandpin123832 1 copy.png')

        return redirect('profile')
    file_path = []

    
    for i in addOn:
        file_path.append(request.session['fileGen'].replace('.png',f'{i}.png'))
    
    request.session['files_path'] = {'0':''}
    for i in range(1,len(file_path)+1):
        request.session['files_path'][i] = request.session['fileGen'].replace('.png',f' {i}.png')

    context= {'imgurl':'google.com','date':date,'filename':file_path}
    return render(request,'app_gen/complete.html',context)

def db(request):
    
    users = User.objects.all()
    if request.GET['pre'] != ' ':
        print(request.GET['pre'])
        return redirect('/pricing')
    
    if request.method == 'POST':
      form = addItem(request.POST)
      if form.is_valid():
        data = User()
        data.name = form.cleaned_data['name']
        data.save()
        print(form.cleaned_data)
      return HttpResponseRedirect(reverse('db'))
    form = addItem()
    params = {'users': users,'form':form}
    
    return render(request,'app_gen/db.html',params)

def profile(request):

    logined  = loginCheck(request)
    billCheck(request)

    imgurl = ImgGen.objects.filter(acc_id=request.session['uid'])
    imgurl = DetailImgGen.objects.filter(gen__in=imgurl,isRemove=False)
    # print(imgurl)
    context = {}
    if request.method == 'POST':
        

        if request.POST['submit'] == 'imgsave':
            import os
            try:
                path = os.path.join(f'./app_gen/static/app_gen/imgGen/',str(request.session['uid']))
                os.mkdir(path)
                
            except:
                pass
            path = './app_gen/static/app_gen/imgGen/'+str(request.session['uid'])+'/'
            # upload = open(path, 'w')
            fileitem = request.FILES['img']
            print(fileitem)

            
            if fileitem.name:
                fn = path + 'profile.png'
                print(path + fileitem.name)
                user = User.objects.get(id=request.session['uid'])
                user.pic = '/static/app_gen/imgGen/'+ str(request.session['uid']) +'/' + 'profile.png'
                user.save()
                request.session['pic'] = '/static/app_gen/imgGen/'+ str(request.session['uid']) +'/' + 'profile.png'
                open(fn, 'wb').write(fileitem.file.read())
        
        elif request.POST['submit'] == 'change':
            user = User.objects.get(id=request.session['uid'])
            user.hash_pass =  md5(request.POST['password'].encode()).hexdigest()
            user.save()
    
        else :
            user = User.objects.get(id=request.session['uid'])
            user.name = request.POST['name']
            user.save()
            request.session['username'] = user.name
            username = request.session['username']
        
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        email = request.session['email']
        context = {'logined':logined,'username':username,'email':email,'pic':pic,'gen':'bg-slate-700','img':imgurl,'notices':NoticesCheck(request)}
    else:
        return HttpResponseRedirect(reverse('login'))
    

        
    return render(request,'app_gen/profile.html',context)

def profileVisit(request,id):

    logined  = loginCheck(request)
   
    userInfo = User.objects.get(id=id)
    srcUser = User.objects.get(id=request.session['uid'])

    followed = Follow.objects.filter(source_id=request.session['uid'])
    print(followed)
    action = True
    if(followed):
        action = False

    img = ImgGen.objects.filter(acc_id=id)
    detail = DetailImgGen.objects.filter(gen__in=img,gen_isPublic=True,isRemove=False)

    imgurl = []
    for image in detail:
        print(image.gen)
        imgurl.append(image.gen)
    
    if(request.method == 'POST'):
        if request.POST['submit'] == 'follow':
            fol = Follow()
            # fol.target_id = id
            # fol.source_id = request.session.uid
            # fol.follow_date = datetime.now()

    
    

    context = {}
    if logined:
        username = userInfo.name
        pic = userInfo.pic
        email = userInfo.userEmail
        context = {'logined':logined,'username':username,'email':email,'pic':pic,'gen':'bg-slate-700','img':detail,'act':action,'notices':NoticesCheck(request)}
    else:
        return HttpResponseRedirect(reverse('login'))
    return render(request,'app_gen/profile.html',context)
def imageDetail(request,id):
    if('uid' not in request.session):
        request.session['errorMSG'] = 'Please Login to see package details.'
        return redirect('product')
    userID = User.objects.get(id=request.session['uid'])
    img = ImgGen.objects.get(gen_id=id)
    detail = DetailImgGen.objects.get(gen_id=id)
    comment = CommentImgGen.objects.filter(gen_id=id).order_by('-date')
    star_name = Star.objects.filter(DetailImgGen=detail.genDetail_id)
    star = star_name.count()
    stared = Star.objects.filter(DetailImgGen=detail.genDetail_id,user=userID)
    ill = Illegal.objects.filter(gen_id=id,status=True)
    # print(ill)
    context = {'img':img,'detail':detail,'id':id,'comments':comment,'star':star,'stared':stared,'reload':False,'ill':ill,'notices':NoticesCheck(request),'star_name':star_name}
    if request.method == "POST":
        if request.POST['submit'] == "save":
            detail.gen_message = request.POST['msg']
            detail.gen_isPublic = request.POST['isPublic'].capitalize()
            print(request.POST['isPublic'])
            detail.save()
        elif request.POST['submit'] == "remove":
            detail.isRemove = True
            detail.save()
            return redirect('profile')
        elif request.POST['submit'] == "comment":
            commentator = User.objects.get(id=request.session['uid'])
            msg = CommentImgGen()
            msg.gen = img
            msg.message = request.POST['text']
            msg.date = datetime.now()
            msg.commentator = commentator
            msg.save()
            
        elif request.POST['submit'] == "del":
            comment = CommentImgGen.objects.get(id=request.POST['cmid'])
            comment.delete()
        elif request.POST['submit'] == 'addStar':
            if(stared):
                print('notStar')
            else:
                print('addStar')
                st = Star()
                st.DetailImgGen = detail
                st.user = userID
                st.save()
                # star = Star.objects.filter(DetailImgGen=detail.genDetail_id).count()
                # context['star'] = star
                context['reload'] = True
        elif request.POST['submit'] == 'dropStar':
            if(stared):
                stared = Star.objects.get(DetailImgGen=detail.genDetail_id,user=userID)
                stared.delete()
                context['reload'] = True
        elif request.POST['submit'] == 'report':
            print('reported',request.POST['repo'])
            normal = Illegal.objects.filter(cop_details=request.POST['repo'],gen_id=id)
            print(normal)
            if(normal):
                pass
            else:
                report = Illegal()
                report.cop_details = request.POST['repo']
                report.gen_id = img
                report.report_date = datetime.now()
                report.save()

                detail.gen_isPublic = False
                detail.save()

                #add Notification
                noti = Notification()
                noti.pic_source = str(img.gen_source) # type: ignore
                noti.acc_id = img.acc_id
                noti.notice_title = 'แจ้งเตือนงานออกแบบ Package ของคุณ'
                noti.notice_detail = f'มีรายงานว่างานออกแบบ Package ID: {img.gen_id} ของคุณได้ละเมิดกฏของเว็บไซต์ของเรา ดังนี้  \'{request.POST["repo"]}\' ตอนนี้ทางผู้ดูแลกำลังตรวจสอบ หากมีข้อสงสัยสามารถติดต่อผู้ดูแลได้'
                noti.notice_date = datetime.now()
                noti.save()

        
                 
    
    return render(request,'app_gen/imageDetail.html',context)

def bin(request):
    logined  = loginCheck(request)
    
    img = ImgGen.objects.filter(acc_id=request.session['uid'])
    detail = DetailImgGen.objects.filter(gen__in=img,isRemove=True)
    
   
    context = {}
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic,'bin':bin,'img':detail,'notices':NoticesCheck(request)}
    else:
        return HttpResponseRedirect(reverse('login'))
    return render(request,'app_gen/bin.html',context)

def binAction(request,id):
        temp = ImgGen.objects.filter(gen_id=id)
        
        if request.POST['submit'] == 'del':
            
            temp.delete()
        elif request.POST['submit'] == 'recover':
            temp = DetailImgGen.objects.get(gen=id)
            temp.isRemove = False
            temp.save()
        return redirect('bin')


def payment(request):
    transection = Transaction.objects.filter(acc_id=request.session['uid'])
    print(request.session['uid'])
    logined  = loginCheck(request)
    context = {}
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic,'payment':'bg-slate-700','history':transection,'notices':NoticesCheck(request)}
    else:
        return HttpResponseRedirect(reverse('login'))
    return render(request,'app_gen/payment.html',context)

def paymentDetail(request,id):

    try:
        transection = Transaction.objects.get(acc_id=request.session['uid'],upgrade_id=id)
        classObj = Class.objects.get(class_price=transection.total_amount)
        logined  = loginCheck(request)
        context = {}
        if logined:
            username = request.session['username']
            pic = request.session['pic']
            context = {'logined':logined,'username':username,'pic':pic,'payment':'bg-slate-700','pay':transection,'plan':classObj,'notices':NoticesCheck(request)}
        else:
            return HttpResponseRedirect(reverse('login'))
        return render(request,'app_gen/paymentDetail.html',context)
    except:
        pass
    return redirect('payment')
    
   
def notiDetail(request,id):
    note = Notification.objects.get(noti_id=id)
    
    note.is_read = True
    note.save()
    context = {'note':note,'noti':'bg-slate-700','notices':NoticesCheck(request)}
    return render(request,'app_gen/notiDetail.html',context)
    # try:
    # except:
    #     note = {}
    #     context = {'note':note,'noti':'bg-slate-700'}
    #     return render(request,'app_gen/notiDetail.html',context)

def notifications(request):
    context = {}
    if loginCheck(request):
        note = Notification.objects.filter(acc_id=request.session['uid']).order_by('-notice_date','is_read')
        context = {'note':note,'noti':'bg-slate-700','notices':NoticesCheck(request)}

        if( 'clear' in request.GET):
            note = Notification.objects.filter(acc_id=request.session['uid'],is_read=True)
            note.delete()
            # request.session['errMSG'] = "Clear all readed."
    else:
        return HttpResponseRedirect(reverse('login'))
    
    
    return render(request,'app_gen/notification.html',context)

def collections(request):
    if(request.method == 'POST'):
        nCol = Collection()
        nCol.col_name = request.POST['col_name']
        nCol.col_user = User.objects.get(id=request.session['uid'])
        nCol.save()
   
    
    col = Collection.objects.filter(col_user=request.session['uid'])
   
    # print(Details)
    print(col.all())
    logined  = loginCheck(request)
    context = {}
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic,'coll':'bg-slate-700','col':col,'notices':NoticesCheck(request)}
    else:
        return HttpResponseRedirect(reverse('login'))
    return render(request,'app_gen/collections.html',context)

def colDetail(request,id):
    col = Collection.objects.get(col_id=id)


    dCol = DetailCollection.objects.filter(col_id=id)
    pack = ImgGen.objects.filter(acc_id=request.session['uid'])
    pack = pack.exclude(gen_id__in=dCol.values("gen_id"))
    
    context = {'images':dCol,'col':col,'packages':pack,'notices':NoticesCheck(request)}

    if 'submit' in request.GET:
        if request.GET['submit'] == 'unsave':
            print(request.GET['id'])
            dCol = DetailCollection.objects.filter(col_id=id,gen_id=request.GET['id'])
            dCol.delete()
        if request.GET['submit'] == 'remove':
            dCol = Collection.objects.filter(col_id=id)
            dCol.delete()
            return redirect('collections')
            
    if request.method == 'POST':

        if request.POST['submit'] == 'rename':
            col.col_name = request.POST['nameCol']
            col.save()
        
        if request.POST['submit'] == 'add':
            genID = request.POST['id'].split(',')
            for item in genID:
                addPack = DetailCollection()
                addPack.col_id = Collection.objects.get(col_id=id)
                addPack.gen_id = ImgGen.objects.get(gen_id=item)
                addPack.save()

       

    return render(request,'app_gen/colDetail.html',context)

def report(request):
    return render(request,'admin/report.html')

def information(request):
    logined  = loginCheck(request)
    context = {}
    if logined:
        username = request.session['username']
        pic = request.session['pic']
        context = {'logined':logined,'username':username,'pic':pic,'info':'bg-slate-700'}
    else:
        return HttpResponseRedirect(reverse('login'))
    return render(request,'app_gen/infomation.html',context)

def loginCheck(request):
    if 'uid' in request.session:
        request.session['logined'] = True
        return True
    else:
        return False

def NoticesCheck(request):
    noti  = Notification.objects.filter(acc_id=request.session['uid'],is_read=False).count()
    return noti

    # user = User.objects.get(userEmail='cookie')
def billCheck(request):
    bill = Transaction.objects.filter(acc_id=request.session['uid']).order_by('-upgrade_id').first()
    print(bill)
    role = request.session['role']
    # print(bill[1].duedate)
    if (bill):
        if (bill.duedate < datetime.now() and request.session['role'] != 'Starter'):#type:ignore
            user = User.objects.get(id=request.session['uid'])
            user.classUser = Class.objects.get(class_id=1)
            user.save()
            request.session['role'] = 'Starter'

             #add Notification
            noti = Notification()
            noti.pic_source = "https://img.freepik.com/free-vector/urgent-concept-illustration_114360-7610.jpg?size=626&ext=jpg&ga=GA1.1.386372595.1698019200&semt=ais" #type:ignore
            noti.acc_id = user
            noti.notice_title = f'แจ้งเตือน Subscription {role} plan ของคุณหมดอายุแล้ว'
            noti.notice_detail = f'แจ้งเตือนการสมัครสมาชิก {role} plan ของคุณหมดอายุแล้ว ณ วันที่ {datetime.now().strftime("%D%M%Y")} ตอนนี้ท่านสามารถใช้งานเว็บไซต์ของเราได้ในระดับ Starter หากต้องการอัปเกรดระดับสามารถเข้า ไปที่หน้า Pricing เพื่อใช้งานอย่างต่อเนื่อง , ขอบคุณที่ใช้บริการของเรา'
            noti.notice_date = datetime.now()
            noti.save()
