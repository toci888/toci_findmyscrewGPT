from django.shortcuts import render

from rest_framework import viewsets
from .models import User, Category, Item, Image, ItemTag, Sale, Transaction, Jar
from .serializers import (
    UserSerializer, CategorySerializer, ItemSerializer, ImageSerializer,
    ItemTagSerializer, SaleSerializer, TransactionSerializer, JarSerializer
)

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from .serializers import ImageUploadSerializer


from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class ItemViewSet(viewsets.ModelViewSet):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer

class ImageViewSet(viewsets.ModelViewSet):
    queryset = Image.objects.all()
    serializer_class = ImageSerializer

class ItemTagViewSet(viewsets.ModelViewSet):
    queryset = ItemTag.objects.all()
    serializer_class = ItemTagSerializer

class SaleViewSet(viewsets.ModelViewSet):
    queryset = Sale.objects.all()
    serializer_class = SaleSerializer

class TransactionViewSet(viewsets.ModelViewSet):
    queryset = Transaction.objects.all()
    serializer_class = TransactionSerializer

class JarViewSet(viewsets.ModelViewSet):
    queryset = Jar.objects.all()
    serializer_class = JarSerializer

# Create your views here.
class ImageUploadView(APIView):
    @swagger_auto_schema(
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'image_base64': openapi.Schema(
                    type=openapi.TYPE_STRING,
                    format='binary',
                    description="Base64 zakodowany obrazek, np. data:image/png;base64,..."
                )
            },
            required=['image_base64'],
        ),
        responses={201: ImageUploadSerializer()},
    )
    def post(self, request, *args, **kwargs):
        serializer = ImageUploadSerializer(data=request.data)
        if serializer.is_valid():
            image_data = serializer.save()
            return Response(image_data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

