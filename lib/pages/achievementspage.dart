import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/achievements/achievements_header.dart';
import 'package:recyclingvin_web/widgets/achievements/badgedisplay.dart';
import 'package:recyclingvin_web/widgets/backgrounds/splashbg.dart';
import 'package:uuid/uuid.dart';

class AchievementsPage extends ConsumerStatefulWidget {
  const AchievementsPage({super.key});

  @override
  ConsumerState<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends ConsumerState<AchievementsPage> {

  final flutterGoogleWalletPlugin = FlutterGoogleWalletPlugin();
  late Future<bool> _isWalletAvailable;

  @override
  void initState() {
    super.initState();
    _isWalletAvailable = Future(() async {
      await flutterGoogleWalletPlugin.initWalletClient();
      return flutterGoogleWalletPlugin.getWalletApiAvailabilityStatus();
    });
  }

  @override
  Widget build(BuildContext context) {

    final badges = ref.watch(badgesVMProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SplashBg(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AchievementsHeader(),
                  RecyclingVinStyles.mediumGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var badge in badges)
                        BadgeDisplay(badgeModel: badge)
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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