# Generated by Django 4.2.1 on 2023-09-13 16:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_gen', '0008_detailimggen_duetime_detailimggen_isremove_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='collection',
            name='total',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='detailimggen',
            name='dueTime',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='detailimggen',
            name='removeAt',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
