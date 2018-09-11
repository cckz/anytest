from tests.models import ExamModel
from rest_framework import viewsets
from tests.serializers import ExamsSerializer, ExamsFullSerializer


class ExamViewSet(viewsets.ModelViewSet):
    queryset = ExamModel.objects.filter(isActive=True)

    def get_serializer_class(self):
        if hasattr(self, 'action'):
            if self.action == 'list':
                return ExamsSerializer
            elif self.action == 'retrieve':
                return ExamsFullSerializer
        return ExamsSerializer
