from django.urls import path , include
from . import views


urlpatterns = [
    path('',views.home,name='home'),
    path('index/',views.home,name='home'),
    path('login/',views.login,name='login'),
    # path('login',include("django.contrib.auth.urls"),name='login'),
    path('register/',views.register,name='register'),

    path('pricing/',views.market,name='market'),
    path('transections/',views.transection,name='transection'),
    path('transections/<id>',views.transectionID,name='transectionID'),
    path('transections/collect/',views.collect_card,name='collect_card'),

    path('product/',views.product,name='product'),

    path('profile/',views.profile,name='profile'),
    path('profile/visit/<id>',views.profileVisit,name='profile'),
    path('profile/generated/',views.profile,name='generated'),
    path('profile/generated/<id>',views.imageDetail,name='imageDetail'),
    path('profile/collections/',views.collections,name='collections'),
    path('profile/collections/<id>',views.colDetail,name='detailCol'),
    path('profile/information/',views.information,name='information'),
    path('profile/notifications/',views.notifications,name='notifications'),
    path('profile/notifications/<id>',views.notiDetail,name='notiDetail'),
    path('profile/payment/',views.payment,name='payment'),
    path('profile/payment/<id>',views.paymentDetail,name='paymentDetail'),
    path('profile/bin/',views.bin,name='bin'),
    path('profile/bin/act/<id>',views.binAction,name='binAction'),
    
    

    path('features/',views.features,name='features'),
    path('company/',views.company,name='company'),
    path('db/',views.db,name='db'),
    path('generator/',views.generator,name='generator'),
    path('generator/complete',views.complete_gen,name='complete'),
    path('generator/collectImg',views.complete_gen,name='generator'),

    path('FAQ/',views.faq,name='questions'),
    path('signout/',views.logout,name='signout'),
    path('signout/',views.logout,name='signout'),
    
    
    path('report/',views.logout,name='report'),

    # path('admin/report/',views.faq,name='admin'),

]