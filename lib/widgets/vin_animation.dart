import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:rive/rive.dart';

class VinAnimation extends ConsumerStatefulWidget {

  const VinAnimation({super.key});

  @override
  ConsumerState<VinAnimation> createState() => _VinAnimationState();
}

class _VinAnimationState extends ConsumerState<VinAnimation> {

  late StateMachineController ctrl;
  late RiveAnimation anim;
  Map<VinAnimationOptions, SMITrigger> poses = {};
  late VinArtboards vinArtboard;
  bool initialized = false;
  double vinDim = 320;

  @override
  void initState() {
    super.initState();

    //vinArtboard = VinArtboards.vinbody;
    vinArtboard = VinArtboards.vinboxride;

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

      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    final laserTrigger = ref.watch(triggerLaserProvider);

    if (initialized && vinArtboard == VinArtboards.vinbody) {
      if(laserTrigger == VinShootingOptions.shoot) {
        poses[VinAnimationOptions.shoot]!.fire();
      }
      else if (laserTrigger == VinShootingOptions.multishoot) {
        poses[VinAnimationOptions.shootmultiple]!.fire();
      }
      else if (laserTrigger == VinShootingOptions.release) {
        poses[VinAnimationOptions.release]!.fire();
      }
      else {
        poses[VinAnimationOptions.walk]!.fire();
      }
    }

    return SizedBox(
      width: vinDim,
      height: vinDim,
      child: Stack(
        children: [
          anim,
          Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(
                top: 140,
                left: 20,
                right: 20,
              ),
              height: vinDim / 3.5,
              key: Utils.vin1,
              color: Colors.transparent,
            ),
          )
        ],
      )
    );
  }
}