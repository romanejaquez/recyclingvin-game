import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class AchievementsHeader extends StatefulWidget {

  const AchievementsHeader({super.key});

  @override
  State<AchievementsHeader> createState() => _AchievementsHeaderState();
}

class _AchievementsHeaderState extends State<AchievementsHeader> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'achievementsheader',
      onInit: onRiveInit,
      fit: BoxFit.fitWidth,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'achievementsheader')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 100,
      child: anim
    );
  }
}