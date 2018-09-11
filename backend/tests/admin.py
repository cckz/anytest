# -*- coding: utf-8 -*-
from django.contrib import admin
from tests.models import ExamModel
from tests.models import QuestModel
from tests.models import AnswerModel
from tests.models import ExamSeesion

class AnswerAdmin(admin.StackedInline):
    model = AnswerModel

class QuestAdmin(admin.ModelAdmin):
    inlines = [AnswerAdmin]

admin.site.register(ExamModel)
admin.site.register(QuestModel, QuestAdmin)
