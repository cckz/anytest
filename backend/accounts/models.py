from django.db import models
from django.contrib.auth.models import User

from tests.models import ExamModel

class UserExtendedModel(models.Model):
    toUser = models.OneToOneField(User, verbose_name='Пользователь', unique=True, on_delete=models.CASCADE, related_name='ext_user')
    toExams = models.ManyToManyField(ExamModel, verbose_name='Тесты пользователя', blank=True, related_name='toExams')

    class Meta:
        ordering = ['toUser']
        verbose_name = 'Пользователь'
        verbose_name_plural = 'Пользователи'

    def __unicode__(self):
        return self.toUser.username

    def __str__(self):
        return self.toUser.username