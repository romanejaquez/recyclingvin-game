import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/pages/achievementspage.dart';
import 'package:recyclingvin_web/pages/gamepage.dart';
import 'package:recyclingvin_web/widgets/backgrounds/splashbg.dart';
import 'package:recyclingvin_web/widgets/achievements/achievements_btn.dart';
import 'package:recyclingvin_web/widgets/controls/start_btn.dart';
import 'package:recyclingvin_web/widgets/logos/splashlogo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  Timer splashTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();
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