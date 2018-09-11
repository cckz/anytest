from accounts.models import UserExtendedModel
from rest_framework import viewsets
from django.contrib.auth.models import User
from accounts.serializers import UserSerializer

class ProfileViewSet(viewsets.ModelViewSet):
    queryset = UserExtendedModel.objects.all().order_by('id')
    serializer_class = UserSerializer

