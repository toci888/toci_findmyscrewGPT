// import 'package:image_picker/image_picker.dart';
// import 'dart:io'; // Potrzebne do pracy z plikami
// import 'package:flutter/material.dart';
// import 'screens/items_screen.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize(); // Inicjalizacja SDK
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FindMyScrew',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: ItemsScreen(),
//     );
//   }
// }

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
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FindMyScrewGPT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : Text(
                    'Brak zdjęcia. Kliknij przycisk, aby zrobić zdjęcie.',
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text('Zrób zdjęcie'),
            ),
          ],
        ),
      ),
    );
  }
}
