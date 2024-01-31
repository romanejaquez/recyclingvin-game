import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class AchievementsButton extends StatefulWidget {

  final VoidCallback onStart;
  const AchievementsButton({
    required this.onStart,
    super.key});

  @override
  State<AchievementsButton> createState() => _AchievementsButtonState();
}

class _AchievementsButtonState extends State<AchievementsButton> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'achievementsbtn',
      onInit: onRiveInit,
      fit: BoxFit.fitWidth,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'achievementsbtn')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onStart,
      child: SizedBox(
        width: 300,
        height: 100,
        child: anim
      ),
    );
  }
}