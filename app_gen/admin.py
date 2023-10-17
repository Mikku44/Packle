
from typing import Any
from django.contrib.admin import AdminSite
from django.core.handlers.wsgi import WSGIRequest
from django.http import HttpResponse
from django.contrib import admin
from django.template.response import TemplateResponse
from app_gen.models import *


from django.contrib.admin import AdminSite
from django.shortcuts import render

class MyAdminSite(AdminSite):
     index_title = 'Dashboard'
     def get_urls(self):
         from django.urls import path
    
         urls = [
            #  path('report/', self.admin_view(self.report)),
         ]
         return urls + super().get_urls()
     
     def index(self, request):
        import datetime

        users = User.objects.all()
        trans = Transaction.objects.all()
        design = ImgGen.objects.all()


        data = ""
        label = ""
        for index,item in enumerate(design):
           data += str(item.pk) 
           label += str(item.pk)
           if index != len(design) - 1:
               data += ','
               label += ','

        context = {'users':users.count(),'trans':trans.count(),'design':design.count(),'data':data,'sum':label}
        return super().index(request,context)


admin.site = MyAdminSite()

# Register your models here.

# @admin.register(User)
class  PackmaUser(admin.ModelAdmin):
    
    list_display = ['id','name',"userEmail",'classUser',"status","regAt","lastLogin","Action"]
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
    list_display = ['genDetail_id','gen','gen_isPublic','gen_message','gen_star','isRemove']
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
    list_display = ['cop_id','cop_details','status','gen_id']
    ordering = ['cop_id']

class PackmaCol(admin.ModelAdmin):
    list_display = ['col_id','col_name']
    ordering = ['col_id']

class PackmaColDeltail(admin.ModelAdmin):
    list_display = ['col_detail_id','col_id','gen_id']
    ordering = ['col_detail_id']

class PackmaNotification(admin.ModelAdmin):
    list_display = ['noti_id','acc_id','is_read','pic_source','notice_title','notice_date','Action']
    ordering = ['noti_id']


class PackmaTransaction(admin.ModelAdmin):
    list_display = ['upgrade_id','acc_id','start_date','duedate','status','purchase_date','total_amount','Action']
    ordering = ['upgrade_id']

class StarAdmin(admin.ModelAdmin):
   pass


admin.site.register(User,PackmaUser)
admin.site.register(Class,PackmaClass)
admin.site.register(DetailImgGen,PackmaDetailImgGen)
admin.site.register(ImgGen,PackmaImgGen)
admin.site.register(Illegal,PackmaIllegal)
admin.site.register(Notification,PackmaNotification)
admin.site.register(Transaction,PackmaTransaction)
admin.site.register(Star,StarAdmin)
admin.site.register(CommentImgGen)
admin.site.register(Collection,PackmaCol)
admin.site.register(DetailCollection,PackmaColDeltail)