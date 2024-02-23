import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/widgets/animations/game_assets_anim.dart';

class SideTreesAnimation extends StatefulWidget {
  const SideTreesAnimation({super.key});

  @override
  State<SideTreesAnimation> createState() => _SideTreesAnimationState();
}

class _SideTreesAnimationState extends State<SideTreesAnimation> {

  @override
  Widget build(BuildContext context) {

    final treeDim = Utils.getDimensionFromAsset(context, GameAssetOptions.tree);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GameAssets(
            uniqueKey: Utils.tree1,
            asset: GameAssetOptions.tree).animate(
            delay: 3.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(-0.125, (MediaQuery.sizeOf(context).height / treeDim!.height)),
            end: const Offset(-0.125, -1),
            duration: 5.seconds,
          ),
      
          GameAssets(
            uniqueKey: Utils.tree2,
            asset: GameAssetOptions.tree).animate(
            delay: 3.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(-0.125, (MediaQuery.sizeOf(context).height / treeDim.height)),
            end: const Offset(-0.125, -1),
            duration: 5.seconds,
          ),
      
          // right side
      
          Positioned(
            right: -0.005,
            top: 0,
            child: GameAssets(
              uniqueKey: Utils.tree3,
              asset: GameAssetOptions.tree).animate(
              delay: 2.seconds,
              onComplete: (controller) {
                controller.repeat();
              },
            )
            .slide(
              begin: Offset(-0.005, (MediaQuery.sizeOf(context).height / treeDim.height)),
              end: const Offset(-0.005, -1),
              duration: 5.seconds,
            ),
          )
        ],
      ),
    );
  }
}