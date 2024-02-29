import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/backgrounds/ground_animation.dart';
import 'package:recyclingvin_web/widgets/backgrounds/side_trees_animation.dart';
import 'package:recyclingvin_web/widgets/core_game_wrapper.dart';
import 'package:recyclingvin_web/widgets/dialogs/playerlost.dart';
import 'package:recyclingvin_web/widgets/onboarding/onboarding_panel.dart';

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
      //Utils.showUIModal(context, const OnboardingPanel());
      Utils.showUIModal(context, const PlayerLostDialog());
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
                  child: CoreGameWrapper()
                )
              : const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}