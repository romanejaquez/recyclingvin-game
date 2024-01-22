import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/widgets/game_assets_anim.dart';

class SideTreesAnimation extends StatefulWidget {
  const SideTreesAnimation({super.key});

  @override
  State<SideTreesAnimation> createState() => _SideTreesAnimationState();
}

class _SideTreesAnimationState extends State<SideTreesAnimation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const GameAssets(asset: GameAssetOptions.tree).animate(
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
      
          const GameAssets(asset: GameAssetOptions.tree).animate(
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
            child: const GameAssets(asset: GameAssetOptions.tree).animate(
              delay: 2.seconds,
              onComplete: (controller) {
                controller.repeat();
              },
            )
            .slide(
              begin: Offset(-0.25, (MediaQuery.sizeOf(context).height / 200)),
              end: const Offset(-0.25, -1),
              duration: 5.seconds,
            ),
          )
        ],
      ),
    );
  }
}