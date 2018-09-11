# -*- coding: utf-8 -*-
from tests.models import ExamModel, QuestModel, AnswerModel
from rest_framework import serializers

class AnswersSerializer(serializers.ModelSerializer):
    class Meta:
        model = AnswerModel
        fields = ('id', 'answer')

class QuestsSerializer(serializers.ModelSerializer):
    answers = AnswersSerializer(many=True, read_only=True)
    rightAnswers = serializers.SerializerMethodField()
    
    def get_rightAnswers(self, obj):
	    return list(obj.answers.filter(success=True).values_list('id', flat=True))

    
    class Meta:
        model = QuestModel
        fields = ('id', 'name', 'quest', 'answers', 'rightAnswers',)

class ExamsFullSerializer(serializers.ModelSerializer):
    exam = QuestsSerializer(many=True, read_only=True)

    class Meta:
        model = ExamModel
        fields = ('id', 'name', 'url', 'countQuest', 'exam',)

class ExamsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExamModel
        fields = ('id', 'name', 'url', 'countQuest',)