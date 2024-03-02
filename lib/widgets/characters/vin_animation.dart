import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  late StateMachineController rideCtrl;
  late RiveAnimation anim;
  late RiveAnimation rideAnim;
  late RiveAnimation mainAnim;
  Map<VinAnimationOptions, SMITrigger> poses = {};
  Map<VinAnimationOptions, SMITrigger> ridingPoses = {};
  late VinArtboards vinArtboard;
  bool bodyInitialized = false;
  bool rideInitialized = false;

  Timer shootingTimer = Timer(0.seconds, () {});

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.mainFile!,
      artboard: VinArtboards.vinbody.name,
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );

    rideAnim = RiveAnimation.direct(Utils.mainFile!,
      artboard: VinArtboards.vinboxride.name,
      onInit: onRiveRideInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, VinArtboards.vinbody.name)!;
    ab.addController(ctrl);

    for (var element in VinAnimationOptions.values) {
      poses[element] = ctrl.findSMI(element.name) as SMITrigger;
    }

    poses[VinAnimationOptions.walk]!.fire();

    if (!bodyInitialized) {
      setState(() {
        bodyInitialized = true;
      });
    }
  }

  void onRiveRideInit(Artboard ab) {

    rideCtrl = StateMachineController.fromArtboard(ab, VinArtboards.vinboxride.name)!;
    ab.addController(rideCtrl);

    for (var element in VinAnimationOptions.values) {
      ridingPoses[element] = rideCtrl.findSMI(element.name) as SMITrigger;
    }

    ridingPoses[VinAnimationOptions.walk]!.fire();
    
    if (!rideInitialized) {
      setState(() {
        rideInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    shootingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final dim = Utils.getDimensionFromAsset(context, GameAssetOptions.vin)!;
    final laserTrigger = ref.watch(triggerLaserProvider);
    final canShoot = ref.watch(shootingCapabilityProvider);
    final cardboardCheck = ref.watch(cardboardCount);

    mainAnim = anim;

    if (cardboardCheck == 1) {
      vinArtboard = VinArtboards.vinboxride;
      bodyInitialized = false;
      mainAnim = rideAnim;
    }

    if (canShoot) {
      if (bodyInitialized) {

        if(laserTrigger == VinShootingOptions.shoot) {
          poses[VinAnimationOptions.shoot]!.fire();
          
          shootingTimer = Timer(const Duration(milliseconds: 500), () {
            shootingTimer.cancel();
          });
        }
        else if (laserTrigger == VinShootingOptions.multishoot) {
          if (!shootingTimer.isActive) {
            poses[VinAnimationOptions.shootmultiple]!.fire();
          }
        }
        else if (laserTrigger == VinShootingOptions.release) {
          poses[VinAnimationOptions.release]!.fire();
        }
        else {
          poses[VinAnimationOptions.walk]!.fire();
        }
      }

      if (rideInitialized) {
        if(laserTrigger == VinShootingOptions.shoot) {
          ridingPoses[VinAnimationOptions.shoot]!.fire();
          
          shootingTimer = Timer(const Duration(milliseconds: 500), () {
            shootingTimer.cancel();
          });
        }
        else if (laserTrigger == VinShootingOptions.multishoot) {
          if (!shootingTimer.isActive) {
            ridingPoses[VinAnimationOptions.shootmultiple]!.fire();
          }
        }
        else if (laserTrigger == VinShootingOptions.release) {
          ridingPoses[VinAnimationOptions.release]!.fire();
        }
        else {
          ridingPoses[VinAnimationOptions.walk]!.fire();
        }
      }
    }
    else {
      if (bodyInitialized) {
        poses[VinAnimationOptions.walk]!.fire();
      }

      if (rideInitialized) {
        ridingPoses[VinAnimationOptions.walk]!.fire();
      }

      shootingTimer.cancel();
    }

    return SizedBox(
      width: dim.width,
      height: dim.height,
      child: Stack(
        children: [
          mainAnim,
          Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(
                top: 140,
              ),
              height: dim.height / 3.5,
              width: dim.width / 1.5,
              key: Utils.vin1,
              color: Colors.transparent,
            ),
          )
        ],
      )
    );
  }
}