# Generated by Django 4.2.1 on 2023-10-31 15:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_gen', '0017_notification_notice_test'),
    ]

    operations = [
        migrations.AddField(
            model_name='notification',
            name='pic_source_upload',
            field=models.ImageField(null=True, upload_to='app_gen/static/notifi_img/'),
        ),
    ]
