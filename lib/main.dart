import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/pages/mainsplash.dart';
import 'package:recyclingvin_web/pages/splashpage.dart';

void main() {
  runApp(const ProviderScope(child: RecyclingVinApp()));
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