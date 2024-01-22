import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return Stack(
      children: [
        SizedBox(
          child: SizedBox(
            width: 350,
            height: 350,
            child: anim,
          ).animate(
            delay: 2.5.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(2, (MediaQuery.sizeOf(context).height / 350)),
            end: Offset(2, -1),
            duration: 4.seconds,
          ),
        ).animate(
          onComplete: (controller) {
            controller.repeat(reverse: true);
          },
        )
        .slide(
          begin: Offset(0.25, 0),
          end: Offset(-0.25, 0),
          duration: 3.seconds,
          curve: Curves.easeInOut,
        ),


        SizedBox(
          child: SizedBox(
            width: 350,
            height: 350,
            child: anim,
          ).animate(
            delay: 3.5.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(2.5, (MediaQuery.sizeOf(context).height / 350)),
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
            width: 350,
            height: 350,
            child: anim,
          ).animate(
            delay: 5.5.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(1.5, (MediaQuery.sizeOf(context).height / 350)),
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