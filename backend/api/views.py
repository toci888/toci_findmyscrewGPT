from django.shortcuts import render

from rest_framework import viewsets
from .models import User, Category, Item, Image, ItemTag, Sale, Transaction, Jar
from .serializers import (
    UserSerializer, CategorySerializer, ItemSerializer, ImageSerializer,
    ItemTagSerializer, SaleSerializer, TransactionSerializer, JarSerializer
)

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


