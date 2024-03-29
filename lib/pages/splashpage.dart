import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/pages/achievementspage.dart';
import 'package:recyclingvin_web/pages/gamepage.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/backgrounds/splashbg.dart';
import 'package:recyclingvin_web/widgets/achievements/achievements_btn.dart';
import 'package:recyclingvin_web/widgets/controls/start_btn.dart';
import 'package:recyclingvin_web/widgets/logos/splashlogo.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SplashPage extends ConsumerStatefulWidget {

  static const String route = '/splash';
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  
  Timer splashTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    ref.read(audioSoundProvider).playBgSound();
  }

  @override
  Widget build(BuildContext context) {

    final splashLogo = getValueForScreenType(
      context: context,
      mobile: 'recyclingvinintrovert',
      tablet: 'recyclingvinintro'
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                  SplashLogo(
                    logo: splashLogo,
                  ),
                  StartButton(
                    onStart: () {
                      ref.read(audioSoundProvider).playSound(RecyclingVinSounds.click);
                      Navigator.of(context).pushNamed(GamePage.route);
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
                      ref.read(audioSoundProvider).playSound(RecyclingVinSounds.click);
                      Navigator.of(context).pushNamed(AchievementsPage.route);
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
      ),
    );
  }
}