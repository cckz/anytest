# -*- coding: utf-8 -*-
from django.urls import path, include
from rest_framework import routers
from tests.views import ExamViewSet

router = routers.DefaultRouter()
router.register(r'exams-full', ExamViewSet)
#router.register(r'exams-full', ExamViewSet)

urlpatterns = [
    path('', include(router.urls))
]
