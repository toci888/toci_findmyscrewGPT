import base64
import uuid
from django.core.files.base import ContentFile
from django.conf import settings
import os
from rest_framework import serializers
from .models import User, Category, Item, Image, ItemTag, Sale, Transaction, Jar
from .models import Image

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class ItemSerializer(serializers.ModelSerializer):
    images = serializers.StringRelatedField(many=True, read_only=True)
    tags = serializers.StringRelatedField(many=True, read_only=True)

    class Meta:
        model = Item
        fields = '__all__'

class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = '__all__'

class ItemTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemTag
        fields = '__all__'

class SaleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sale
        fields = '__all__'

class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = '__all__'

class JarSerializer(serializers.ModelSerializer):
    class Meta:
        model = Jar
        fields = '__all__'



class PhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = '__all__'
        
    
class ImageUploadSerializer(serializers.Serializer):
    image_base64 = serializers.CharField(help_text="Base64 kodowany obrazek (np. data:image/png;base64,...)")

    def create(self, validated_data):
        image_data = validated_data['image_base64']
        format, imgstr = image_data.split(';base64,')  # Rozdzielamy nagłówek od danych
        ext = format.split('/')[-1]  # Pobieramy rozszerzenie (jpg/png)

        # Generujemy unikalną nazwę pliku
        file_name = f"{uuid.uuid4()}.{ext}"
        file_path = os.path.join(settings.MEDIA_ROOT, 'uploads', file_name)

        # Dekodujemy obraz i zapisujemy na dysku
        with open(file_path, "wb") as f:
            f.write(base64.b64decode(imgstr))

        return {"image_url": f"/media/uploads/{file_name}"}