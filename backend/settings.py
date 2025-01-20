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
    'corsheaders',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
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

CORS_ALLOW_ALL_ORIGINS = True
