import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class LaserBtn extends StatefulWidget {
  const LaserBtn({super.key});

  @override
  State<LaserBtn> createState() => _LaserBtnState();
}

class _LaserBtnState extends State<LaserBtn> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'laserbtn',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'laserbtn')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: anim
    );
  }
}