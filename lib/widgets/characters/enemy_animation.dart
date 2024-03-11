import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final enemyDim = Utils.getDimensionFromAsset(context, GameAssetOptions.frackingstein)!;
    final enemyWidthOffset = (MediaQuery.sizeOf(context).width - enemyDim.width) / enemyDim.width;

    double enemyEdgeOffset = getValueForScreenType(
      context: context, 
      mobile: 0.25,
      tablet: 1.5
    );
    
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
            begin: Offset(enemyEdgeOffset, (MediaQuery.sizeOf(context).height / enemyDim.height)),
            end: Offset(enemyEdgeOffset, -1),
            duration: 5.seconds,
          ),
        ).animate(
          onComplete: (controller) {
            controller.repeat(reverse: true);
          },
        )
        .slide(
          delay: 1.seconds,
          begin: const Offset(0.25, 0),
          end: const Offset(-0.25, 0),
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
            begin: Offset(enemyWidthOffset - enemyEdgeOffset, (MediaQuery.sizeOf(context).height / enemyDim.height)),
            end: Offset(enemyWidthOffset - enemyEdgeOffset, -1),
            duration: 6.seconds,
          ),
        ).animate(
          onComplete: (controller) {
            controller.repeat(reverse: true);
          },
        )
        .slide(
          delay: 1.seconds,
          begin: const Offset(0.25, 0),
          end: const Offset(-0.25, 0),
          duration: 5.5.seconds,
          curve: Curves.easeInOut,
        ),
      ],
    );
  }
}