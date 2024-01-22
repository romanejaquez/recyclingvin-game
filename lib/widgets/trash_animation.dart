import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/widgets/game_assets_anim.dart';

class TrashAnimation extends StatefulWidget {
  const TrashAnimation({super.key});

  @override
  State<TrashAnimation> createState() => _TrashAnimationState();
}

class _TrashAnimationState extends State<TrashAnimation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const GameAssets(asset: GameAssetOptions.cardboardbox).animate(
            delay: 3.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(1, (MediaQuery.sizeOf(context).height / 150)),
            end: const Offset(1, -1),
            duration: 3.5.seconds,
          ),
      
          const GameAssets(asset: GameAssetOptions.sodacan).animate(
            delay: 4.seconds,
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(2, (MediaQuery.sizeOf(context).height / 150)),
            end: const Offset(2, -1),
            duration: 4.5.seconds,
          ),
      
          // right side
      
          Positioned(
            right: 0,
            top: 0,
            child: const GameAssets(asset: GameAssetOptions.waterbottle).animate(
              delay: 2.seconds,
              onComplete: (controller) {
                controller.repeat();
              },
            )
            .slide(
              begin: Offset(-2, (MediaQuery.sizeOf(context).height / 150)),
              end: const Offset(-2, -1),
              duration: 5.5.seconds,
            ),
          )
        ],
      ),
    );
  }
}