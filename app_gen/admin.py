from django.shortcuts import redirect, render
from typing import Any
from django.contrib.admin import AdminSite
from django.core.handlers.wsgi import WSGIRequest
from django.http import HttpResponse
from django.contrib import admin
from django.template.response import TemplateResponse
from app_gen.models import *
from datetime import datetime, timedelta
from django import forms
from django.contrib.admin import AdminSite
from django.shortcuts import render
from django.db.models import Sum


@admin.action(description="ตรวจสอบแล้ว")
def accept_report(modeladmin, request, queryset):

    print(request.POST)
    print(request.path)
    queryset.update(status=True)
    # for obj in queryset:
    #     obj.status = True
    #     obj.save()


class MyAdminSite(AdminSite):
     index_title = 'Dashboard'
     def get_urls(self):
         from django.urls import path
    
         urls = [
             path('app_gen/illegal/accept/', self.admin_view(self.accept_ill)),
         ]
         return urls + super().get_urls()
     def accept_ill(self, request):
         try:
            if('Accept' in request.GET):
                ill = Illegal.objects.get(cop_id=request.GET['Accept'])
                ill.status = True
                ill.save()
            elif('Unaccept' in request.GET):
                ill = Illegal.objects.get(cop_id=request.GET['Unaccept'])
                ill.status = False
                ill.save()
         except:
            pass
        #  return HttpResponse(request.GET['accept'])
         return redirect('/admin/app_gen/illegal/')
     def index(self, request):
        from dateutil.relativedelta import relativedelta 

        users = User.objects.all()
        trans = Transaction.objects.all()
        design = ImgGen.objects.all()
       
        popularp = DetailImgGen.objects.filter(gen_isPublic=True,isRemove=False).order_by('-gen_star')[:5]

        revenue = Transaction.objects.aggregate(Sum('total_amount'))['total_amount__sum']

        data = []
        tdata = []
        pdata = []
        rdata = [0]
        months = []
        # for index,item in enumerate(design):
        #    data += str(item.pk) 
        #    label += str(item.pk)
        #    if index != len(design) - 1:
        #        data += ','
        #        label += ','

        if (users):
            f = users[0].regAt
            l = users[len(users)-1].regAt
            while (f.strftime("%Y") <= l.strftime("%Y")):#type:ignore
            
                fYear = int(f.strftime("%Y"))#type:ignore
                firstMonth = int(f.strftime("%m"))#type:ignore
                # print(f'{f.month} {l.month}')#type:ignore
                if(f > l):#type:ignore
                    break
                data.append(str(User.objects.filter(regAt__lte=f).count()))#type:ignore

                f += relativedelta(months=1) # type: ignore

                # {"month":"8" ,"year" :"2023"}
                months.append(f"{firstMonth}/{fYear}")
        
        data.append(str(User.objects.filter(regAt__lte=f).count()))#type:ignore
        months.append(f"{firstMonth}/{fYear}")# type: ignore

        months = str(months).replace("'",'"')
        data = str(data).replace("'",'"')
        # print(str(months).replace("'",'"'))


        if (trans):
            f = (trans[0].start_date + relativedelta(day=31)).replace(hour=0, minute=0, second=0)#type:ignore
            l = trans[len(trans)-1].start_date

            while (f.strftime("%Y") <= l.strftime("%Y")):#type:ignore
                fYear = int(f.strftime("%Y"))#type:ignore
                firstMonth = int(f.strftime("%m"))#type:ignore
                # print(f'Year : {firstMonth} f: {(f)}')#type:ignore
                query = Transaction.objects.filter(start_date__lte=(f))#type:ignore
                tdata.append(str(query.count()))#type:ignore
                # query = Transaction.objects.filter(purchase_date__lt=(f))#type:ignore
                rpm = query.aggregate(Sum('total_amount'))['total_amount__sum']
                rpm = rpm - int(rdata[-1])
                rdata.append(str(rpm))
                print(type(rpm - int(rdata[-1])))
                # for i in query:
                #     print(i.start_date)
                f += relativedelta(months=1) # type: ignore

                # {"month":"8" ,"year" :"2023"}
                # months.append(f"{firstMonth}/{fYear}")

        tdata = str(tdata).replace("'",'"')

        if (design):
            f = (design[0].gen_CreateAt + relativedelta(day=31)).replace(hour=0, minute=0, second=0)#type:ignore
            l = design[len(design)-1].gen_CreateAt
            while (f.strftime("%Y") <= l.strftime("%Y")):#type:ignore
                fYear = int(f.strftime("%Y"))#type:ignore
                firstMonth = int(f.strftime("%m"))#type:ignore
                # print(f'Year : {firstMonth} f: {(f)}')#type:ignore
                query = ImgGen.objects.filter(gen_CreateAt__lte=(f))#type:ignore
                pdata.append(str(query.count()))#type:ignore

                # for i in query:
                #     print(i.start_date)
                f += relativedelta(months=1) # type: ignore

                # {"month":"8" ,"year" :"2023"}
                # months.append(f"{firstMonth}/{fYear}")

        pdata = str(pdata).replace("'",'"')

        del rdata[0]
        rdata = str(rdata).replace("'",'"')
        
        print(rdata)
        

        context = {'users':users.count(),'trans':trans.count(),'transvalue':trans,'design':design.count(),'data':data,'tdata':tdata,'pdata':pdata,'range':months,'revenue':revenue,'rdata':rdata,'popular':popularp}
        return super().index(request,context)


admin.site = MyAdminSite()

# Register your models here.




# @admin.register(User)
class  PackmaUser(admin.ModelAdmin):
    
    list_display = ['id','name',"userEmail",'classUser',"status","lastLogin","Action"]
    # field = ['name']
    search_fields = ['name']
    ordering  = ['id']
    list_filter = ["status"]

    
# @admin.register(Class)
class PackmaClass(admin.ModelAdmin):
    
    list_display = ['class_id','class_name','class_detail','class_price','max_gen_per_date','Action']
    list_display_links = None
    
    ordering = ['class_id']
    empty_value = ["-There are not any class now.-"]
    
    

# @admin.register(DetailImgGen)
class PackmaDetailImgGen(admin.ModelAdmin):
    def getSource(self, obj):
        gen_source = obj.gen.gen_source
        return format_html(f'<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src="{gen_source}" style="width:100%;"></img></div>')
    list_display = ['genDetail_id','gen','getSource','gen_isPublic','gen_message','gen_star','isRemove']
    ordering = ['genDetail_id']
    
    class Meta:
        verbose_name_plural = "Image Generation Detail"

        

# @admin.register(ImgGen)
class PackmaImgGen(admin.ModelAdmin):
    list_display = ['gen_id','Preview','acc_id','UserName','gen_CreateAt','Action']
    list_display_links =  None
    ordering = ['gen_id']
    
    class Meta:
        verbose_name_plural = "Image Generation"

# @admin.register(Illegal)
class PackmaIllegal(admin.ModelAdmin):

    def acceptReport(self,obj):
        
        if(obj.status == True):
            action = "Unaccept"
        else:
            action = "Accept"
        return format_html(f'<a href="./accept/?{action}={obj.cop_id}"><div style="color:white;border-radius:5px;padding:10px 5px;background:#79aec8;text-align:center;">{action}</div></a>')
    def getSource(self, obj):
        gen_source = obj.gen_id.gen_source
        return format_html(f'<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src="{gen_source}" style="width:100%;"></img></div>')
    list_display = ['cop_id','cop_details','status','gen_id','getSource','acceptReport']
    ordering = ['cop_id']
    actions = [accept_report]

class PackmaCol(admin.ModelAdmin):
    def username(self,obj):
        return obj.col_user.name
    list_display = ['col_id','col_name','col_user','username']
    ordering = ['col_id']

class PackmaColDeltail(admin.ModelAdmin):
    def getSource(self, obj):
        gen_source = obj.gen_id.gen_source
        return format_html(f'<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src="{gen_source}" style="width:100%;"></img></div>')
    list_display = ['col_detail_id','col_id','gen_id','getSource']
    ordering = ['col_detail_id']

class PackmaNotification(admin.ModelAdmin):
  
    # def getSource(self, obj):
    #     source = obj.pic_source
    #     return format_html(f'<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src="{source}" style="width:100%;"></img></div>')
    
    list_display = ['noti_id','acc_id','is_read','notice_title','notice_date','Action']
    ordering = ['noti_id']
    # fields = ['is_read','acc_id','notice_title','pic_source','notice_detail','notice_date']



class PackmaTransaction(admin.ModelAdmin):
   

    list_display = ['upgrade_id','acc_id','start_date','duedate','status','purchase_date','total_amount','Action']
    ordering = ['upgrade_id']

class StarAdmin(admin.ModelAdmin):
    def getSource(self, obj):
        gen_source = obj.DetailImgGen.gen.gen_source
        return format_html(f'<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src="{gen_source}" style="width:100%;"></img></div>')
    list_display = ['DetailImgGen','user']


class CommentAdmin(admin.ModelAdmin):
    def getSource(self, obj):
        gen_source = obj.gen.gen_source
        return format_html(f'<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src="{gen_source}" style="width:100%;"></img></div>')
    list_display = ['getSource','message','date','commentator']


admin.site.register(User,PackmaUser)
admin.site.register(Class,PackmaClass)
admin.site.register(DetailImgGen,PackmaDetailImgGen)
admin.site.register(ImgGen,PackmaImgGen)
admin.site.register(Illegal,PackmaIllegal)
admin.site.register(Notification,PackmaNotification)
admin.site.register(Transaction,PackmaTransaction)
admin.site.register(Star,StarAdmin)
admin.site.register(CommentImgGen,CommentAdmin)
admin.site.register(Collection,PackmaCol)
admin.site.register(DetailCollection,PackmaColDeltail)
admin.site.empty_value_display = "(None)"