<?php
require_once 'PHPMailer.php';
require_once 'SMTP.php';
require_once 'Exception.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Pobierz dane z formularza
    $name = htmlspecialchars($_POST['name']);
    $email = htmlspecialchars($_POST['email']);
    $phone = htmlspecialchars($_POST['phone']);
    $message = htmlspecialchars($_POST['message']);
    $city = htmlspecialchars($_POST['city']);

    // Tworzenie instancji PHPMailer
    $mail = new PHPMailer(true);

    try {
        // Ustawienia serwera SMTP
        $mail->isSMTP();
        $mail->Host = 'serwer2461761.home.pl'; // Wstaw adres serwera SMTP
        $mail->SMTPAuth = true;
        $mail->Username = 'warrior@toci.pl'; // Wstaw swój adres email
        $mail->Password = 'ABY83beatka!@#'; // Wstaw swoje hasło
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        // Ustawienia odbiorcy i nadawcy
        $mail->setFrom('warrior@toci.pl', 'Formularz kontaktowy');
        $mail->addAddress('bartlomiejzapart47@gmail.com'); // Wstaw swój adres email
        $mail->addReplyTo($email, $name);

        // Treść wiadomości
        $mail->isHTML(false);
        $mail->Subject = 'Nowa wiadomosc z formularza kontaktowego';
        $mail->Body = "Imię: $name\nEmail: $email\ntelefon: $phone\nMiejscowośc: $city \nWiadomość:\n$message";

        // Wyślij wiadomość
        $mail->send();
        echo json_encode(['success' => 'true']);
    } catch (Exception $e) {
        echo "Wystąpił błąd podczas wysyłania wiadomości: {$mail->ErrorInfo}";
    }
} else {
    echo "Nieprawidłowe żądanie.";
}
?>
