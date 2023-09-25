from django.db import models
from datetime import datetime
from django.utils.html import format_html
import requests

# # Create your models here.
def ActionBtn(id):
    return format_html('<div style="display:flex;column-gap:10px;"><a href="{}/change" style="background:#79aec8;padding:10px;text-align:center;color:white;">Edit</a><a href={}/delete style="background:#79aec8;padding:10px;text-align:center;color:white;">Delete</a></div>'.format(id,id))


class Class(models.Model):
    class_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    class_name = models.CharField(max_length=100,null=False)
    class_detail = models.CharField(max_length=1000,default="")
    class_price = models.FloatField(default=0,null=False)
    max_gen_per_date = models.IntegerField(default=0,null=False)

    @property
    def Action(self):
        return ActionBtn(self.class_id)
    class Meta:
        verbose_name_plural = "Classes"
    
    def __str__(self):
        return self.class_name
    
class User(models.Model):
    id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    userEmail = models.EmailField(max_length=255,unique=True,default="none@email.com")
    hash_pass = models.CharField(max_length=255,default="")
    pic = models.CharField(max_length=255,default="https://images.unsplash.com/photo-1635614017406-7c192d832072?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80")
    status = models.BooleanField(default=False)
    regAt = models.DateTimeField(null=True)
    lastLogin = models.DateTimeField(null=True)
    classUser = models.ForeignKey(Class,on_delete=models.PROTECT,null=True)
    name = models.CharField(max_length=255)
    note = models.TextField(max_length=255,default="",blank=True)
    
    @property
    def Action(self):
        return ActionBtn(self.id)
    

    def __str__(self):
        return self.userEmail


class ImgGen(models.Model):
    gen_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    gen_source = models.CharField(max_length=1000,null=False)
   
    acc_id = models.ForeignKey(User,on_delete=models.PROTECT,null=True)
    gen_CreateAt = models.DateTimeField()

   
    def delete(self):
        import os
        path = './app_gen/static/app_gen/imgGen/'+ str(self.acc_id.id)
        dir = os.listdir(path)
        for index in dir:
            path = './app_gen/static/app_gen/imgGen/'+ str(self.acc_id.id) + '/' + index
            if(len(os.listdir(path)) == 0):
                os.rmdir(path)
        try:
            
            source = "./app_gen"+self.gen_source.replace('%20',' ')
            print(source)
            os.remove(source)
            
        except:
            pass
        super().delete()
        
        # os.remove("demofile.txt")
        # super().save()

         
         

    @property
    def Action(self):
        return ActionBtn(self.gen_id)
    
    @property
    def Preview(self):
        return format_html('<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src={} style="width:100%;"></img></div>'.format(self.gen_source))
    
    @property
    def UserName(self):
        return self.acc_id.name
    def __str__(self):
        return 'ID #' + str(self.gen_id) 
    class Meta:
        verbose_name_plural = "Packaging"

class DetailImgGen(models.Model):
    genDetail_id =models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    gen_isPublic = models.BooleanField(default=False)
    gen = models.OneToOneField(ImgGen,on_delete=models.CASCADE,null=True)
    gen_message = models.TextField(blank=True,max_length=255,default="")
    gen_star = models.IntegerField(default=0)

    isRemove = models.BooleanField(default=False)
    dueTime  = models.DateTimeField(null=True,blank=True)
    removeAt = models.DateTimeField(null=True,blank=True)


    
    class Meta:
        verbose_name_plural = "Packaging Detail"

    def __str__(self):
        return f'ID : {str(self.genDetail_id)} , {str(self.gen_message)}'


class Star(models.Model):
    DetailImgGen = models.ForeignKey(DetailImgGen,on_delete=models.CASCADE,null=True)
    user = models.ForeignKey(User,on_delete=models.CASCADE,null=True)

    def __str__(self):
        return self.user.name
    
        
    
class CommentImgGen(models.Model):

    gen = models.ForeignKey(ImgGen,on_delete=models.CASCADE,null=True)
    message = models.TextField(blank=True,max_length=255,default="")
    date = models.DateTimeField(null=True, blank=True)
    commentator = models.ForeignKey(User,on_delete=models.CASCADE)

    class Meta:
        verbose_name_plural = "Comments"

    def __str__(self):
        return str(self.message)


class Illegal(models.Model):
    cop_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    cop_details = models.CharField(max_length=1000,null=False)
    status  = models.BooleanField(default=False)
    gen_id = models.ForeignKey(ImgGen,on_delete=models.CASCADE,null=False)

    @property
    def Action(self):
        return ActionBtn(self.cop_id)

# class Bin(models.Model):
    
#     # bin_id = models.BigAutoField(auto_created=True, primary_key=True, verbose_name='ID')
#     # gen_id   = models.OneToOneField(ImgGen,on_delete=models.CASCADE,null=False,primary_key=True)
#     # acc = models.ForeignKey(User,on_delete=models.CASCADE,null=True)
#     gen_id   = models.ForeignKey(ImgGen,on_delete=models.CASCADE,null=True)
#     status = models.BooleanField(default=False)
#     dueTime  = models.DateTimeField(null=True)
#     removeAt = models.DateTimeField(null=True)

#     def __str__(self):
#         return str(self.gen_id)
    
class CreditCard(models.Model):
    id = models.BigAutoField(auto_created=True,primary_key=True, serialize=False,)
    acc = models.ForeignKey(User,on_delete=models.CASCADE,null=False,default=None)
    creditNum = models.CharField(max_length=255,null=False)
    creditName = models.CharField(max_length=255,null=False)
    address = models.CharField(max_length=255,null=False)
    CVC = models.CharField(max_length=4,null=False)
    DDVV = models.CharField(max_length=5,null=False)

class Notification(models.Model):
    noti_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    pic_source = models.CharField(max_length=255,default="",blank=True)
    is_read = models.BooleanField(default=False)
    acc_id = models.ForeignKey(User, on_delete=models.CASCADE,null=True)
    notice_title = models.CharField(max_length=255,null=False)
    notice_detail = models.TextField(max_length=800,default="")
    notice_date = models.DateTimeField(null=True)
    @property
    def Action(self):
        return ActionBtn(self.noti_id)
    def __str__(self):
        return self.notice_title

    
    
class Follow(models.Model):
    follow_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    source_id = models.ManyToManyField(User,related_name='source_id')
    target_id = models.ManyToManyField(User,related_name='target_id')
    follow_date = models.DateTimeField(null=True)



class Transaction(models.Model):
    upgrade_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')
    acc_id = models.ForeignKey(User, on_delete=models.CASCADE)
    start_date = models.DateTimeField(null=True)
    duedate = models.DateTimeField(null=True)
    status = models.BooleanField(default=False)
    purchase_date = models.DateTimeField(null=True,blank=True)
    total_amount = models.IntegerField(default=1)

    @property
    def Action(self):
        return ActionBtn(self.upgrade_id)
    def __str__(self):
        return str(self.upgrade_id)


class Collection(models.Model):
    col_id = models.BigAutoField(auto_created=True,primary_key=True,serialize=False,verbose_name='ID')
    col_name = models.CharField(max_length=100,null=False)

    def __str__(self):
        return self.col_name


class DetailCollection(models.Model):
    col_detail_id = models.BigAutoField(auto_created=True,primary_key=True,serialize=False,verbose_name='ID') 
    col_id = models.ForeignKey(Collection,on_delete=models.CASCADE)
    gen_id = models.ForeignKey(ImgGen,on_delete=models.CASCADE)

    def __str__(self):
        return format_html('<div style="width:10vw; overflow:hidden;border-radius:10px;"><img src={} style="width:100%;"></img></div>'.format(self.gen_id.gen_source))

