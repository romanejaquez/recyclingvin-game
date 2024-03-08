import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/pages/achievementspage.dart';
import 'package:recyclingvin_web/pages/gamepage.dart';
import 'package:recyclingvin_web/pages/mainsplash.dart';
import 'package:recyclingvin_web/pages/splashpage.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(const ProviderScope(child: RecyclingVinApp()));
}

class RecyclingVinApp extends StatelessWidget {
  const RecyclingVinApp({super.key});

  @override
  Widget build(BuildContext context) {

    final deviceOrientations = getValueForScreenType(context: context, 
      mobile: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      tablet: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]
    );

    SystemChrome.setPreferredOrientations(deviceOrientations);

    return MaterialApp(
      localizationsDelegates: const [
      I18nGoogleWallet.delegate,
    ],
      theme: ThemeData(
        fontFamily: 'Mabook'
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: MainSplashPage.route,
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        MainSplashPage.route: (context) => const MainSplashPage(),
        AchievementsPage.route: (context) => const AchievementsPage(),
        GamePage.route: (context) => const GamePage(),
      }
    );
  }
}