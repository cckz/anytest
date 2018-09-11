# -*- coding: utf-8 -*-
from rest_framework import serializers
from django.contrib.auth.models import User
from accounts.models import UserExtendedModel
from tests.serializers import ExamsFullSerializer

class UserSerializer(serializers.ModelSerializer):
    toExams = ExamsFullSerializer(many=True, read_only=True)
    username = serializers.SerializerMethodField()
    id = serializers.SerializerMethodField()
    
    def get_username(self, obj):
        return obj.toUser.username
    
    def get_id(self, obj):
        return obj.toUser.id
        
    class Meta:
        model = UserExtendedModel
        fields = ('id', 'username', 'toExams',)

#class UserSerializer(serializers.ModelSerializer):
#    ext_user = UserExtendedSerializer(many=False, read_only=True)
#    class Meta:
#        model = User
#        fields = ('id', 'username', 'toExams',)