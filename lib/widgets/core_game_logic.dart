import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/control_bottom_bar.dart';
import 'package:recyclingvin_web/widgets/enemy_animation.dart';
import 'package:recyclingvin_web/widgets/laser_shots.dart';
import 'package:recyclingvin_web/widgets/top_counter_bar.dart';
import 'package:recyclingvin_web/widgets/trash_animation.dart';
import 'package:recyclingvin_web/widgets/vin_animation.dart';

class CoreGameLogic extends ConsumerStatefulWidget {
  const CoreGameLogic({super.key});

  @override
  ConsumerState<CoreGameLogic> createState() => _CoreGameLogicState();
}

class _CoreGameLogicState extends ConsumerState<CoreGameLogic> {

  Timer loopTimer = Timer(0.seconds, () {});

  @override
  void initState() {
    super.initState();

    loopTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Utils.checkForCollision(Utils.vin1, Utils.cardboard, () {
        ref.read(cardboardCount.notifier).state += 1;
      });

      Utils.checkForCollision(Utils.vin1, Utils.waterBottle, () {
        ref.read(waterBottleCount.notifier).state += 1;
      });

      Utils.checkForCollision(Utils.vin1, Utils.sodaCan, () {
        ref.read(sodaCanCount.notifier).state += 1;
      });

      Utils.checkForCollision(Utils.vin1, Utils.enemy1, () {
        
      });

      Utils.checkForCollision(Utils.vin1, Utils.enemy2, () {
        
      });

      // Utils.checkForCollision(Utils.laser, Utils.enemy1, () {
        
      // });

      // Utils.checkForCollision(Utils.laser, Utils.enemy2, () {
        
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        const TrashAnimation(),

        Consumer(
          builder: (context, ref, child) {
            return Positioned(
              top: MediaQuery.sizeOf(context).height / 3,
              left: ref.watch(vinPositionProvider) ?? (MediaQuery.sizeOf(context).width / 2) - 160,
              child: const Stack(
                children: [
                  Center(child: VinAnimation()),
                ],
              ),
            );
          }
        ),

        Center(
          child: LaserShots()
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
}