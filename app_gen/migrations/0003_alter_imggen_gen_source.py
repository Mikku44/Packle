# Generated by Django 4.2.1 on 2023-08-29 15:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app_gen', '0002_remove_imggen_gendetail_id_detailimggen_gen_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='imggen',
            name='gen_source',
            field=models.CharField(max_length=1000),
        ),
    ]
