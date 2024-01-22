import 'package:flutter/material.dart';
import 'package:recyclingvin_web/pages/mainsplash.dart';
import 'package:recyclingvin_web/pages/splashpage.dart';

void main() {
  runApp(const RecyclingVinApp());
}

class RecyclingVinApp extends StatelessWidget {
  const RecyclingVinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainSplash()
    );
  }
}