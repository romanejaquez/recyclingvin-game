import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/pages/mainsplash.dart';

void main() {
  runApp(const ProviderScope(child: RecyclingVinApp()));
}

class RecyclingVinApp extends StatelessWidget {
  const RecyclingVinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
      I18nGoogleWallet.delegate,
    ],
      theme: ThemeData(
        fontFamily: 'Mabook'
      ),
      debugShowCheckedModeBanner: false,
      home: const MainSplash()
    );
  }
}