# Generated by Django 2.0.3 on 2018-04-05 18:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tests', '0005_questmodel_successasnwers'),
    ]

    operations = [
        migrations.AddField(
            model_name='answermodel',
            name='id_answer',
            field=models.CharField(blank=True, max_length=1, verbose_name='ID ответа'),
        ),
    ]
