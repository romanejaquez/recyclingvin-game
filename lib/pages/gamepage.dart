import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/pages/splashpage.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/backgrounds/ground_animation.dart';
import 'package:recyclingvin_web/widgets/backgrounds/side_trees_animation.dart';
import 'package:recyclingvin_web/widgets/core_game_wrapper.dart';
import 'package:recyclingvin_web/widgets/panels/gamepanels.dart';

class GamePage extends ConsumerStatefulWidget {

  static const String route = '/game';
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {

  Timer dialogTimer = Timer(0.seconds, () {});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dialogTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {

        ref.read(gameLoopProvider).exitGame();

        if (didPop) {
          return;
        }

        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    RecyclingVinColors.topGreenGradient,
                    RecyclingVinColors.bottomGreenGradient,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
            ),
      
            Positioned.fill(
              child: SvgPicture.asset('./assets/imgs/roadbg.svg',
                fit: BoxFit.fill,
              ),
            ),
      
            const GroundAnimation(),
      
            const SideTreesAnimation(),
      
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(gameStartedFlagProvider) ? 
                  const Positioned.fill(
                    child: CoreGameWrapper()
                  )
                : const SizedBox.shrink();
              },
            ),
      
            const GamePanels(),
          ],
        ),
      ),
    );
  }
}