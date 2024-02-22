import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class EnemyAnimation extends StatefulWidget {
  const EnemyAnimation({super.key});

  @override
  State<EnemyAnimation> createState() => _EnemyAnimationState();
}

class _EnemyAnimationState extends State<EnemyAnimation> {

  late StateMachineController ctrl;
  late RiveAnimation anim;
  double enemyDim = 280;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.mainFile!,
      artboard: 'frackenstein',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'frackenstein')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {

    final enemyDim = Utils.getDimensionFromAsset(context, GameAssetOptions.frackingstein)!;
    
    return Stack(
      children: [
        SizedBox(
          child: SizedBox(
            width: enemyDim.width,
            height: enemyDim.height,
            child: Stack(
              children: [
                anim,
                Center(
                  child: Container(
                    key: Utils.enemy1,
                    alignment: Alignment.center,
                    width: enemyDim.width / 3,
                    height: enemyDim.height / 3,
                    margin: const EdgeInsets.only(bottom: 20),
                    color: Colors.transparent,
                  ),
                )
              ],
            )
          ).animate(
            delay: 3.5.seconds,
            onInit:(controller) {
              Utils.controllerMap[Utils.enemy1] = controller;
            },
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(2.5, (MediaQuery.sizeOf(context).height / enemyDim.height)),
            end: Offset(2.5, -1),
            duration: 5.seconds,
          ),
        ).animate(
          onComplete: (controller) {
            controller.repeat(reverse: true);
          },
        )
        .slide(
          delay: 1.seconds,
          begin: Offset(0.25, 0),
          end: Offset(-0.25, 0),
          duration: 5.5.seconds,
          curve: Curves.easeInOut,
        ),


        SizedBox(
          child: SizedBox(
            width: enemyDim.width,
            height: enemyDim.height,
            child: Stack(
              children: [
                anim,
                Center(
                  child: Container(
                    key: Utils.enemy2,
                    alignment: Alignment.center,
                    width: enemyDim.width / 3,
                    height: enemyDim.height / 3,
                    margin: const EdgeInsets.only(bottom: 20),
                    color: Colors.transparent,
                  ),
                )
              ],
            )
          ).animate(
            delay: 5.5.seconds,
            onInit:(controller) {
              Utils.controllerMap[Utils.enemy2] = controller;
            },
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(1.5, (MediaQuery.sizeOf(context).height / enemyDim.height)),
            end: Offset(1.5, -1),
            duration: 6.seconds,
          ),
        ).animate(
          onComplete: (controller) {
            controller.repeat(reverse: true);
          },
        )
        .slide(
          delay: 1.seconds,
          begin: Offset(0.25, 0),
          end: Offset(-0.25, 0),
          duration: 5.5.seconds,
          curve: Curves.easeInOut,
        ),
      ],
    );
  }
}