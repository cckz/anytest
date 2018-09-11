# -*- coding: utf-8 -*-
from django.urls import path, include
from rest_framework import routers
# from api.views import UserViewSet, GroupViewSet
from tests.views import ExamViewSet
from accounts.views import ProfileViewSet

router = routers.DefaultRouter()
# router.register(r'users', UserViewSet)
# router.register(r'groups', GroupViewSet)
router.register(r'exams', ExamViewSet)
router.register(r'profile', ProfileViewSet)

urlpatterns = [
    path('', include(router.urls))
]
