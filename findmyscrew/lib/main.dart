import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Potrzebne do pracy z plikami
import 'package:flutter/material.dart';
import 'screens/items_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize(); // Inicjalizacja SDK
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindMyScrew',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ItemsScreen(),
    );
  }
}