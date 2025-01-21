
    $(document).ready(function () {
        // Obsługa zdarzenia przesyłania formularza
        $('form').on('submit', function (e) {
            e.preventDefault(); // Zapobiega domyślnemu przesłaniu formularza

            // Pobierz dane z formularza
            const formData = {
                name: $('#name').val(),
                email: $('#email').val(),
                phone: $('#phone').val(),
                city: $('#city').val(),
                message: $('#message').val(),
            };

            // Wykonaj żądanie AJAX
            $.ajax({
                url: 'php/contact.php', // Ścieżka do pliku PHP obsługującego żądanie
                method: 'POST',
                data: formData,
                dataType: 'json', // Oczekiwany format odpowiedzi
                success: function (response) {
                    if (response.success) {
                        alert('Dziękujemy za przesłanie formularza! Skontaktujemy się z Tobą wkrótce.');
                        $('form')[0].reset(); // Zresetuj formularz po pomyślnym przesłaniu
                    } else {
                        alert('Wystąpił problem podczas przesyłania formularza. Spróbuj ponownie.');
                    }
                },
                error: function () {
                    alert('Błąd sieci! Sprawdź połączenie z internetem i spróbuj ponownie.');
                },
            });
        });
    });
