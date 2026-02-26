import 'package:flutter/material.dart';
import 'package:organibot/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organibot',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen()
    );
  }
}
