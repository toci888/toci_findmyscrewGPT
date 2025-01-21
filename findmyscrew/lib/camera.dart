import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image; // Przechowywanie wybranego zdjęcia

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera, // Źródło: aparat
      maxWidth: 1200,             // Opcjonalne: zmiana rozmiaru zdjęcia
      imageQuality: 100,          // Opcjonalne: jakość zdjęcia (0-100)
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Zapisz zdjęcie
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aparat fotograficzny")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(
                    _image!,          // Wyświetlenie zdjęcia
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : Text("Nie zrobiono zdjęcia"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage, // Funkcja wywołująca aparat
              child: Text("Zrób zdjęcie"),
            ),
          ],
        ),
      ),
    );
  }
}
