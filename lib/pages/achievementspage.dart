import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/achievements/achievements_header.dart';
import 'package:recyclingvin_web/widgets/achievements/badgedisplay.dart';
import 'package:recyclingvin_web/widgets/backgrounds/splashbg.dart';

class AchievementsPage extends ConsumerStatefulWidget {
  const AchievementsPage({super.key});

  @override
  ConsumerState<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends ConsumerState<AchievementsPage> {
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