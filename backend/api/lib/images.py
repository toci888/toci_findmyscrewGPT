from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import default_storage

@csrf_exempt
def upload_image(request):
    if request.method == 'POST' and request.FILES['file']:
        file = request.FILES['file']
        file_name = default_storage.save(file.name, file)
        # Procesowanie obrazu (np. wysłanie do modelu AI)
        return JsonResponse({'message': f'Plik {file_name} przetworzony pomyślnie.'})
    return JsonResponse({'error': 'Nieprawidłowe żądanie'}, status=400)
