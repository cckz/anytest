# -*- coding: utf-8 -*-
from django.db import models
from django.contrib.auth.models import User

class ExamModel(models.Model):
    name = models.CharField(max_length=100, verbose_name='Название теста')
    isActive = models.BooleanField(default=True, verbose_name='Активнен')
    countQuest = models.IntegerField(verbose_name='Число вопросов', default=0)

    class Meta:
        db_table = 'Exams'
        ordering = ['name']
        verbose_name = 'Тест'
        verbose_name_plural = 'Тесты'

    def __unicode__(self):
        return self.name

    def __str__(self):
        return self.name

    def getCountQuests(self):
        return self.exam.filter(toExam=self).count()

class QuestModel(models.Model):
    name = models.CharField(max_length=15, verbose_name='Номер теста', default='Вопрос №: ')
    quest = models.TextField(verbose_name='Вопрос')
    toExam = models.ForeignKey(ExamModel, verbose_name='Тест', related_name='exam', on_delete=models.CASCADE)
    successAsnwers = models.CharField(verbose_name='Правильные ответы', max_length=20, blank=True)

    class Meta:
        db_table = 'Quets'
        ordering = ['name']
        verbose_name = 'Вопрос'
        verbose_name_plural = 'Вопросы'

    def __unicode__(self):
        return self.name

    def __str__(self):
        return self.name

#    def getSuccessAnswers(self):
#        return self.answers.filter(toQuest=self, success=True)

    def save(self, *args, **kwargs):
        super(QuestModel, self).save(*args, **kwargs)
        self.toExam.countQuest = self.toExam.getCountQuests()
        self.toExam.save()

class AnswerModel(models.Model):
    toQuest = models.ForeignKey(QuestModel, verbose_name='Ответ', related_name='answers', on_delete=models.CASCADE)
    answer = models.TextField(verbose_name='Ответ')
    success = models.BooleanField(verbose_name='Правильный ответ', default=False)

    class Meta:
        db_table = 'Answer'
        verbose_name = 'Ответ'
        verbose_name_plural = 'Ответы'

    def __unicode__(self):
        return self.answer

    def __str__(self):
        return self.answer

class ExamSeesion(models.Model):
    examID = models.CharField(max_length=50, db_index=True)
    quest = models.ForeignKey(QuestModel, unique=False, blank=True, on_delete=models.CASCADE, null=True)
    answer = models.ForeignKey(AnswerModel, unique=False, blank=True, on_delete=models.CASCADE, null=True)
    createAt = models.DateTimeField(auto_now_add=True, verbose_name='Дата экзамена')
    user = models.OneToOneField(User, verbose_name='Пользователь', on_delete=models.CASCADE)

    class Meta:
        db_table = 'exam_items'
        verbose_name = 'Результат'
        verbose_name_plural = 'Результаты'
