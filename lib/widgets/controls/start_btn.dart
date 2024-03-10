import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class StartButton extends StatefulWidget {

  final VoidCallback onStart;
  const StartButton({
    required this.onStart,
    super.key});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'startbtn',
      onInit: onRiveInit,
      fit: BoxFit.fitWidth,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'startbtn')!;
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