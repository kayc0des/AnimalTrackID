// lib/main.dart
import 'package:flutter/material.dart';
import 'features/onboarding/splashscreen_one.dart'; // import the file you want to run

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenOne(), // You can set your screen here
    );
  }
}
