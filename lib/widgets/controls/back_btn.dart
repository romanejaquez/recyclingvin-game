import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class GameBackButton extends StatefulWidget {

  final VoidCallback onBack;
  const GameBackButton({
    required this.onBack,
    super.key});

  @override
  State<GameBackButton> createState() => _GameBackButtonState();
}

class _GameBackButtonState extends State<GameBackButton> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'backbtn',
      onInit: onRiveInit,
      fit: BoxFit.fitWidth,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'backbtn')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onBack,
      child: SizedBox(
        width: 200,
        height: 100,
        child: anim
      ),
    );
  }
}