from rest_framework.routers import DefaultRouter
from django.urls import path, include
from .views import (
    UserViewSet, CategoryViewSet, ItemViewSet, ImageViewSet,
    ItemTagViewSet, SaleViewSet, TransactionViewSet, JarViewSet
)

router = DefaultRouter()
router.register('users', UserViewSet)
router.register('categories', CategoryViewSet)
router.register('items', ItemViewSet)
router.register('images', ImageViewSet)
router.register('item-tags', ItemTagViewSet)
router.register('sales', SaleViewSet)
router.register('transactions', TransactionViewSet)
router.register('jars', JarViewSet)

urlpatterns = router.urls

from drf_spectacular.views import SpectacularAPIView, SpectacularRedocView, SpectacularSwaggerView

urlpatterns = [
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),  # OpenAPI Schema
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),  # Swagger UI
    path('api/redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),  # Redoc
]
