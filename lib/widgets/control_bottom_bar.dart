import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/laser_btn.dart';
import 'package:recyclingvin_web/widgets/move_slider.dart';

class ControlBottomBar extends ConsumerWidget {
  const ControlBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MoveSlider(),
        LaserBtn(
          onTrigger: (VinShootingOptions option) {
            ref.read(triggerLaserProvider.notifier).state = option;
          }
        )
      ],
    );
  }
}