import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/achievements/achievements_header.dart';
import 'package:recyclingvin_web/widgets/achievements/badgedisplay.dart';
import 'package:recyclingvin_web/widgets/backgrounds/splashbg.dart';
import 'package:recyclingvin_web/widgets/controls/back_btn.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';

class AchievementsPage extends ConsumerStatefulWidget {

  static const String route = '/achievements';
  const AchievementsPage({super.key});

  @override
  ConsumerState<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends ConsumerState<AchievementsPage> {

  final flutterGoogleWalletPlugin = FlutterGoogleWalletPlugin();
  late Future<bool> _isWalletAvailable;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    
    checkForWalletAvailability();
  }

  void checkForWalletAvailability() async {
    _isWalletAvailable = Future(() async {
      await flutterGoogleWalletPlugin.initWalletClient();
      return flutterGoogleWalletPlugin.getWalletApiAvailabilityStatus();
    });
  }

  @override
  Widget build(BuildContext context) {

    final badges = ref.watch(badgesCollectedVMProvider);

    final showBackButton = getValueForScreenType(
      context: context, 
      mobile: false,
      tablet: true,
    );

    final showPageViewerBullets = getValueForScreenType(
      context: context, 
      mobile: true,
      tablet: false,
    );

    final backButtonWidget = Visibility(
      visible: showBackButton,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: RecyclingVinStyles.largePadding.copyWith(
            top: RecyclingVinStyles.largePadding.top / 2,
          ),
          child: GameBackButton(
            onBack: () {
              Navigator.of(context).pop();
            },
          ).animate(
            onComplete: (controller) => controller.repeat(reverse: true),
          )
          .slideY(
            begin: 0.125, end: 0,
            curve: Curves.easeInOut,
            duration: 1.5.seconds,
          ),
        ),
      ),
    );

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
                  Padding(
                    padding: const EdgeInsets.all(RecyclingVinStyles.largeSize)
                      .copyWith(bottom: 0),
                    child: const AchievementsHeader(),
                  ),
                  RecyclingVinStyles.mediumGap,
                  FutureBuilder(
                    future: _isWalletAvailable,
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(RecyclingVinColors.vinBrown),
                            )
                          ),
                        );
                      }

                      final badgeList = [
                        for (var badge in badges)
                          BadgeDisplay(
                            isWalletAvailable: snapshot.data!,
                            badgeModel: badge,
                            onAddBadge: () {
                              var payload = badge.metadata.walletPayload();
                              flutterGoogleWalletPlugin.savePasses(
                                jsonPass: payload,
                                addToGoogleWalletRequestCode: 2
                              );
                            }  
                          )
                      ];

                      final badgeContainer = getValueForScreenType(
                        context: context, 
                        mobile: Expanded(
                          child: PageView(
                            children: badgeList,
                            onPageChanged: (value) {
                              setState(() {
                                pageIndex = value;
                              });
                            },
                          ),
                        ),
                        tablet: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: badgeList,
                        )
                      );

                      
                      return badgeContainer;
                            
                    }
                  ),
                  RecyclingVinStyles.mediumGap,
                  Visibility(
                  visible: showPageViewerBullets,
                  child: Container(
                    padding: RecyclingVinStyles.largePadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(badges.length,
                        (index) {
                          return Container(
                            width: 20, height: 20,
                            margin: RecyclingVinStyles.smallPadding,
                            decoration: BoxDecoration(
                              color: RecyclingVinColors.vinBrown
                                .withOpacity(index == pageIndex ? 1 : 0.25),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                    ),
                  ),
                )
                ],
              ),
            ),
            backButtonWidget
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