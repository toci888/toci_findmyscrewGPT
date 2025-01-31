from rest_framework.routers import DefaultRouter
from django.urls import path, include
from .views import (
    UserViewSet, CategoryViewSet, ItemViewSet, ImageViewSet,
    ItemTagViewSet, SaleViewSet, TransactionViewSet, JarViewSet
)
from .views import ImageUploadView
from django.conf import settings
from django.conf.urls.static import static

router = DefaultRouter()
router.register('users', UserViewSet)
router.register('categories', CategoryViewSet)
router.register('items', ItemViewSet)
router.register('images', ImageViewSet)
router.register('item-tags', ItemTagViewSet)
router.register('sales', SaleViewSet)
router.register('transactions', TransactionViewSet)
router.register('jars', JarViewSet)



from django.contrib import admin
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView, SpectacularRedocView

urlpatterns = [
    #router.urls,
    #path('admin/', admin.site.urls),
    #path('api/', include('api.urls')),  # Include your app's URLs
  ##  path('api/photos/', include('photos.urls')),
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),  # OpenAPI Schema
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),  # Swagger UI
    path('api/redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),  # Redoc UI
    path('upload-image/', ImageUploadView.as_view(), name='upload-image'),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += router.urls