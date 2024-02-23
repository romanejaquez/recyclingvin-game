import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/widgets/animations/game_assets_anim.dart';

class TrashAnimation extends ConsumerStatefulWidget {
  const TrashAnimation({super.key});

  @override
  ConsumerState<TrashAnimation> createState() => _TrashAnimationState();
}

class _TrashAnimationState extends ConsumerState<TrashAnimation> {
  @override
  Widget build(BuildContext context) {

    var trashWidgetOffset = ((MediaQuery.sizeOf(context).width - 250) / 250);
    var centerTrashWidgetOffset = trashWidgetOffset / 2;
    var trashDim = Utils.getDimensionFromAsset(context, GameAssetOptions.cardboardbox);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GameAssets(
          uniqueKey: Utils.cardboard,
          asset: GameAssetOptions.cardboardbox)
          .animate(
            delay: 3.seconds,
            onInit:(controller) {
              Utils.controllerMap[Utils.cardboard] = controller;
            },
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(1, (MediaQuery.sizeOf(context).height / trashDim!.height)),
            end: const Offset(1, -1),
            duration: 3.5.seconds,
          ),
    
        GameAssets(
          uniqueKey: Utils.sodaCan,
          asset: GameAssetOptions.sodacan).animate(
          delay: 4.seconds,
          onInit:(controller) {
            Utils.controllerMap[Utils.sodaCan] = controller;
          },
          onComplete: (controller) {
            controller.repeat();
          },
        )
        .slide(
          begin: Offset(centerTrashWidgetOffset, (MediaQuery.sizeOf(context).height / trashDim.height)),
          end: Offset(centerTrashWidgetOffset, -1),
          duration: 4.5.seconds,
        ),
    
        // right side
    
        GameAssets(
          uniqueKey: Utils.waterBottle,
          asset: GameAssetOptions.waterbottle).animate(
          delay: 2.seconds,
          onInit:(controller) {
            Utils.controllerMap[Utils.waterBottle] = controller;
          },
          onComplete: (controller) {
            controller.repeat();
          },
        )
        .slide(
          begin: Offset(trashWidgetOffset - 1, (MediaQuery.sizeOf(context).height / trashDim.height)),
          end: Offset(trashWidgetOffset - 1, -1),
          duration: 5.5.seconds,
        )
      ],
    );
  }
}