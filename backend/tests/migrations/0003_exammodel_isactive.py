# Generated by Django 2.0.3 on 2018-03-07 10:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tests', '0002_auto_20180307_1041'),
    ]

    operations = [
        migrations.AddField(
            model_name='exammodel',
            name='isActive',
            field=models.BooleanField(default=True, verbose_name='Активнен'),
        ),
    ]