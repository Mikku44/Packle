# Generated by Django 4.2.1 on 2023-10-31 15:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_gen', '0016_remove_follow_source_id_remove_follow_target_id_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='notification',
            name='notice_test',
            field=models.TextField(default='', max_length=800),
        ),
    ]