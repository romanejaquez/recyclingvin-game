import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class SplashBg extends StatefulWidget {
  const SplashBg({super.key});

  @override
  State<SplashBg> createState() => _SplashBgState();
}

class _SplashBgState extends State<SplashBg> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.mainFile!,
      artboard: 'vinsplash',
      onInit: onRiveInit,
      fit: BoxFit.cover,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'vinsplash')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: anim
    );
  }
}