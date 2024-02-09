import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/controls/laser_btn.dart';
import 'package:recyclingvin_web/widgets/controls/laser_energy_level.dart';
import 'package:recyclingvin_web/widgets/controls/move_slider.dart';

class ControlBottomBar extends ConsumerWidget {
  const ControlBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(RecyclingVinStyles.x3largeSize),
                    topRight: Radius.circular(RecyclingVinStyles.x3largeSize),
                  ),
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MoveSlider(),
              const Expanded(
                child: LaserEnergyLevel(),
              ),
              LaserBtn(
                onTrigger: (VinShootingOptions option) {
                  ref.read(triggerLaserProvider.notifier).state = option;
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}