import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/animations/trash_animation.dart';
import 'package:recyclingvin_web/widgets/characters/enemy_animation.dart';
import 'package:recyclingvin_web/widgets/animations/laser_shots.dart';
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
          child: Consumer(
            builder: (context, ref, child) {

              final canShoot = ref.watch(shootingCapabilityProvider);
              return canShoot ? const LaserShots() : const SizedBox.shrink();
            }
          ),
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
    super.dispose();
  }
}