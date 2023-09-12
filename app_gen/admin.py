from django.contrib import admin
from app_gen.models import *

# Register your models here.
class Statistic():
    pass


@admin.register(User)
class  PackmaUser(admin.ModelAdmin):
    
    list_display = ['name',"userEmail",'classUser',"status","regAt","lastLogin","Action"]
    search_fields = ['name']
    list_filter = ["status"]
    
@admin.register(Class)
class PackmaClass(admin.ModelAdmin):
    
    list_display = ['class_id','class_name','class_detail','class_price','max_gen_per_date','Action']
    list_display_links = None
    
    ordering = ['class_id']
    empty_value = ["-There are not any class now.-"]
    
    

@admin.register(DetailImgGen)
class PackmaDetailImgGen(admin.ModelAdmin):
    list_display = ['genDetail_id','gen','gen_isPublic','gen_message','gen_star','isRemove']
    ordering = ['genDetail_id']
    
    class Meta:
        verbose_name_plural = "Image Generation Detail"
        

@admin.register(ImgGen)
class PackmaImgGen(admin.ModelAdmin):
    list_display = ['gen_id','Preview','acc_id','UserName','gen_CreateAt','Action']
    list_display_links =  None
    ordering = ['gen_id']
    
    class Meta:
        verbose_name_plural = "Image Generation"

@admin.register(Illegal)
class PackmaIllegal(admin.ModelAdmin):
    list_display = ['cop_id','cop_details','status','gen_id']
    ordering = ['cop_id']

# @admin.register(Bin)
# class PackmaBin(admin.ModelAdmin):
#     list_display = ['id','dueTime','removeAt']
#     ordering = ['id']

# @admin.register(Collection)
# class PackmaCol(admin.ModelAdmin):
#     list_display = ['col_id','col_name']
#     ordering = ['col_id']

# @admin.register(DetailCollection)
# class PackmaColDeltail(admin.ModelAdmin):
#     list_display = ['col_detail_id','col_id','gen_id']
#     ordering = ['col_detail_id']


@admin.register(Notification)
class PackmaNotification(admin.ModelAdmin):
    list_display = ['noti_id','acc_id','is_read','pic_source','notice_title','notice_date','Action']
    ordering = ['noti_id']

@admin.register(Transaction)
class PackmaTransaction(admin.ModelAdmin):
    list_display = ['upgrade_id','acc_id','start_date','duedate','status','purchase_date','total_amount','Action']
    ordering = ['upgrade_id']


admin.site.register(CommentImgGen)
# admin.site.register(User,PackmaUser)
# admin.site.register(Class,PackmaClass)