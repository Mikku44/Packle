# Generated by Django 4.2.1 on 2023-09-21 22:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_gen', '0011_remove_collection_total_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='test',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('img', models.ImageField(upload_to='static/test/')),
            ],
        ),
    ]
