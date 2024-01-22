import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class VinAnimation extends StatefulWidget {

  const VinAnimation({super.key});

  @override
  State<VinAnimation> createState() => _VinAnimationState();
}

class _VinAnimationState extends State<VinAnimation> {

  late StateMachineController ctrl;
  late RiveAnimation anim;
  Map<VinAnimationOptions, SMITrigger> poses = {};
  late VinArtboards vinArtboard;

  @override
  void initState() {
    super.initState();

    vinArtboard = VinArtboards.vinbody;
    //vinArtboard = VinArtboards.vinboxride;

    anim = RiveAnimation.direct(Utils.mainFile!,
      artboard: vinArtboard.name,
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, vinArtboard.name)!;
    ab.addController(ctrl);

    if (vinArtboard == VinArtboards.vinbody) {
      for (var element in VinAnimationOptions.values) {
        poses[element] = ctrl.findSMI(element.name) as SMITrigger;
      }

      poses[VinAnimationOptions.walk]!.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (vinArtboard == VinArtboards.vinbody) {
          poses[VinAnimationOptions.shoot]!.fire();
        }
      },
      child: SizedBox(
        width: 350,
        height: 350,
        child: anim
      ),
    );
  }
}