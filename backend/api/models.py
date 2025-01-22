from django.db import models
from django.utils.translation import gettext_lazy as _

class PaymentStatus(models.TextChoices):
    PENDING = 'PENDING', _('Oczekujące')
    COMPLETED = 'COMPLETED', _('Zakończone')
    FAILED = 'FAILED', _('Niepowodzenie')
    
class User(models.Model):
    username = models.CharField(max_length=50)
    email = models.EmailField(unique=True)
    password_hash = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.username

class Category(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.TextField()

    def __str__(self):
        return self.name

class Item(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True)
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Image(models.Model):
    item = models.ForeignKey(Item, on_delete=models.CASCADE, related_name='images')
    image_url = models.URLField()
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Image for {self.item.name}"

class ItemTag(models.Model):
    item = models.ForeignKey(Item, on_delete=models.CASCADE, related_name='tags')
    tag_name = models.CharField(max_length=50)

    def __str__(self):
        return self.tag_name

class Sale(models.Model):
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=3, default='USD')
    is_sold = models.BooleanField(default=False)
    platform = models.CharField(max_length=50, default='Vinted')
    listed_at = models.DateTimeField(auto_now_add=True)

class Transaction(models.Model):
    sale = models.ForeignKey(Sale, on_delete=models.CASCADE)
    buyer_name = models.CharField(max_length=100)
    buyer_contact = models.TextField()
    transaction_date = models.DateTimeField(auto_now_add=True)

class Jar(models.Model):
    shelf = models.IntegerField()
    description = models.TextField(blank=True)
    content_type = models.CharField(max_length=50, blank=True)
    weight_grams = models.IntegerField()
    is_empty = models.BooleanField(default=False)
    added_at = models.DateTimeField(auto_now_add=True)



# Create your models here.

class Client(models.Model):
    first_name = models.CharField(max_length=50)  # Imię klienta
    last_name = models.CharField(max_length=50)   # Nazwisko klienta
    email = models.EmailField(unique=True)        # E-mail
    phone_number = models.CharField(max_length=15)  # Numer telefonu
    street_address = models.CharField(max_length=255)  # Ulica i numer
    city = models.CharField(max_length=100)       # Miasto
    postal_code = models.CharField(max_length=10) # Kod pocztowy
    account_number = models.CharField(max_length=34, unique=True)  # Numer konta bankowego
    created_at = models.DateTimeField(auto_now_add=True)  # Data utworzenia rekordu
    updated_at = models.DateTimeField(auto_now=True)      # Data ostatniej aktualizacji

    def __str__(self):
        return f"{self.first_name} {self.last_name} - {self.email}"

class Client_Transaction(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE, related_name="transactions")
    amount = models.DecimalField(max_digits=10, decimal_places=2)  # Kwota przelewu
    status = models.CharField(max_length=10, choices=PaymentStatus.choices, default=PaymentStatus.PENDING)
    created_at = models.DateTimeField(auto_now_add=True)  # Data utworzenia transakcji
    completed_at = models.DateTimeField(null=True, blank=True)  # Data zakończenia transakcji

    def __str__(self):
        return f"Transakcja dla {self.client.first_name} {self.client.last_name}: {self.amount} PLN ({self.status})"
