import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class SplashLogo extends StatefulWidget {

  final String logo;
  const SplashLogo({
    required this.logo,
    super.key
  });

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.introFile!,
      artboard: widget.logo,
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, widget.logo)!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: anim
    );
  }
}