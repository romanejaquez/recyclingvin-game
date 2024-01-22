import 'package:flutter/material.dart';
import 'package:recyclingvin_web/widgets/laser_btn.dart';
import 'package:recyclingvin_web/widgets/move_slider.dart';

class ControlBottomBar extends StatelessWidget {
  const ControlBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MoveSlider(),
        LaserBtn()
      ],
    );
  }
}