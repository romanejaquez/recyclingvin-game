import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class OnboardingBadge extends StatefulWidget {

  final OnboardingBadgeOptions option;
  const OnboardingBadge({
    required this.option,
    super.key
  });

  @override
  State<OnboardingBadge> createState() => _OnboardingBadgeState();
}

class _OnboardingBadgeState extends State<OnboardingBadge> {
  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: widget.option.name,
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, widget.option.name)!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: ValueKey(anim),
      width: 300,
      height: 300,
      child: anim
    );
  }
}