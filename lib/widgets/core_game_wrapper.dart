import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/animations/trash_animation.dart';
import 'package:recyclingvin_web/widgets/characters/enemy_animation.dart';
import 'package:recyclingvin_web/widgets/animations/laser_shots.dart';
import 'package:recyclingvin_web/widgets/characters/vin_animation.dart';
import 'package:recyclingvin_web/widgets/characters/vin_movement_wrapper.dart';
import 'package:recyclingvin_web/widgets/controls/control_bottom_bar.dart';
import 'package:recyclingvin_web/widgets/panels/top_counter_bar.dart';

class CoreGameWrapper extends ConsumerStatefulWidget {
  const CoreGameWrapper({super.key});

  @override
  ConsumerState<CoreGameWrapper> createState() => _CoreGameLogicState();
}

class _CoreGameLogicState extends ConsumerState<CoreGameWrapper> {

  @override
  void initState() {
    super.initState();

    ref.read(gameLoopProvider).startGameLoop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        const TrashAnimation(),

        const VinMovementWrapper(),

        Positioned(
          top: (MediaQuery.sizeOf(context).height / 3) - 25,
          child: const LaserShots(),
        ),

        const EnemyAnimation(),

        const Align(
          alignment: Alignment.bottomCenter,
          child: ControlBottomBar()
        ),

        const Align(
          alignment: Alignment.topRight,
          child: TopCounterBar(),
        )
      ],
    );
  }

  @override
  void dispose() {
    ref.read(gameLoopProvider).stopGameLoop();
    super.dispose();
  }
}