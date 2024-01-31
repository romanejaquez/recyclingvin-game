import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/pages/achievementspage.dart';
import 'package:recyclingvin_web/pages/gamepage.dart';
import 'package:recyclingvin_web/widgets/backgrounds/splashbg.dart';
import 'package:recyclingvin_web/widgets/achievements/achievements_btn.dart';
import 'package:recyclingvin_web/widgets/controls/start_btn.dart';
import 'package:recyclingvin_web/widgets/logos/duuprgameslogo.dart';
import 'package:recyclingvin_web/widgets/logos/splashlogo.dart';
import 'package:uuid/uuid.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  final flutterGoogleWalletPlugin = FlutterGoogleWalletPlugin();
  Timer splashTimer = Timer(Duration.zero, () {});
  late Future<bool> _isWalletAvailable;


  @override
  void initState() {
    super.initState();

    super.initState();
    _isWalletAvailable = Future(() async {
      await flutterGoogleWalletPlugin.initWalletClient();
      return flutterGoogleWalletPlugin.getWalletApiAvailabilityStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SplashBg(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RecyclingVinStyles.mediumGap,
                const SplashLogo(),
                StartButton(
                  onStart: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GamePage()));
                  },
                ).animate(
                  onComplete: (controller) {
                    controller.repeat(reverse: true);
                  },
                ).slideY(
                  begin: 0.05, end: -0.05,
                  curve: Curves.easeInOut,
                  duration: 1.seconds,
                ),

                AchievementsButton(
                  onStart: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AchievementsPage()));
                  },
                ).animate(
                  onComplete: (controller) {
                    controller.repeat(reverse: true);
                  },
                ).slideY(
                  begin: -0.05, end: 0.05,
                  curve: Curves.easeInOut,
                  duration: 0.8.seconds,
                ),
              ],
            ),
          ),
          
        ],
      )
    );
  }
}

final String _passId = const Uuid().v4();
const String _passClass = 'bag-buster-badge';
const String _issuerId = '3388000000022314022';
const String _issuerEmail = 'romanejaquez@gmail.com';

final String _examplePass = """ 
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#F6BA15",
            "logo": {
              "sourceUri": {
                "uri": "https://romanejaquez.github.io/recyclingvin-assets/badges/recyclingvinlogo.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Bag Buster Badge"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Recycling Vin"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Alex McJacobs"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://romanejaquez.github.io/recyclingvin-assets/badges/badgebagbuster.png"
              }
            },
            "textModulesData": [
              {
                "header": "GAME ACHIEVEMENT",
                "body": "200",
                "id": "bags"
              }
            ]
          }
        ]
      }
    }
""";