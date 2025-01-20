from rest_framework.routers import DefaultRouter
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
