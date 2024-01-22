import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';

class GroundAnimation extends StatefulWidget {
  const GroundAnimation({super.key});

  @override
  State<GroundAnimation> createState() => _GroundAnimationState();
}

class _GroundAnimationState extends State<GroundAnimation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset('./assets/imgs/groundtiles.svg',
            width: 200,
            height: 200,
          ).animate(
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(0.25, (MediaQuery.sizeOf(context).height / 200)),
            end: const Offset(0.25, -1),
            duration: 5.seconds,
          ),
      
          SvgPicture.asset('./assets/imgs/groundtiles.svg',
            width: 200,
            height: 200,
          ).animate(
            delay: 3.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(0.25, (MediaQuery.sizeOf(context).height / 200)),
            end: const Offset(0.25, -1),
            duration: 5.seconds,
          ),
      
          // right side
      
          Positioned(
            right: 0,
            top: 0,
            child: SvgPicture.asset('./assets/imgs/groundtiles.svg',
              width: 200,
              height: 200,
            ).animate(
              delay: 2.seconds,
              onComplete: (controller) {
                controller.repeat();
              },
            )
            .slide(
              begin: Offset(-0.5, (MediaQuery.sizeOf(context).height / 200)),
              end: const Offset(-0.5, -1),
              duration: 5.seconds,
            ),
          )
        ],
      ),
    );
  }
}