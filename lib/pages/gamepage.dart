import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/core_game_logic.dart';
import 'package:recyclingvin_web/widgets/ground_animation.dart';
import 'package:recyclingvin_web/widgets/onboarding_panel.dart';
import 'package:recyclingvin_web/widgets/side_trees_animation.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Utils.showUIModal(context, const OnboardingPanel());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                  child: CoreGameLogic()
                )
              : const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}