# Generated by Django 2.0.3 on 2018-03-07 10:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tests', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='questmodel',
            name='name',
            field=models.CharField(default='Вопрос №: ', max_length=15, verbose_name='Номер теста'),
        ),
    ]
