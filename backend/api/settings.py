INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'drf_yasg',
    'api',
    'drf_spectacular',
    'rest_framework',
    'photos',
]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'toci_findmyscrewGPT',       # Nazwa bazy danych
        'USER': 'postgres',          # Nazwa użytkownika PostgreSQL
        'PASSWORD': 'beatka',  # Hasło użytkownika
        'HOST': 'localhost',         # Adres hosta
        'PORT': '5432',              # Port PostgreSQL (domyślnie 5432)
    }
}

REST_FRAMEWORK = {
 
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
}

SPECTACULAR_SETTINGS = {
    'TITLE': 'FindMyScrew API',
    'DESCRIPTION': 'API documentation for the FindMyScrew project.',
    'VERSION': '1.0.0',
    'SERVE_INCLUDE_SCHEMA': False,  # This prevents the schema from being included in the Swagger UI.
}

STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

import os

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

# Dodaj MEDIA_URL do `urls.py` projektu
from django.conf import settings
from django.conf.urls.static import static

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
