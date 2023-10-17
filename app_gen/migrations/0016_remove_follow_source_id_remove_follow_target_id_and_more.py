# Generated by Django 4.2.1 on 2023-10-13 21:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_gen', '0015_collection_col_user'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='follow',
            name='source_id',
        ),
        migrations.RemoveField(
            model_name='follow',
            name='target_id',
        ),
        migrations.AddField(
            model_name='follow',
            name='source_id',
            field=models.BigIntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='follow',
            name='target_id',
            field=models.BigIntegerField(blank=True, null=True),
        ),
    ]