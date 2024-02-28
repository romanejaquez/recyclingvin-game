import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/widgets/animations/game_assets_anim.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TrashAnimation extends ConsumerStatefulWidget {
  const TrashAnimation({super.key});

  @override
  ConsumerState<TrashAnimation> createState() => _TrashAnimationState();
}

class _TrashAnimationState extends ConsumerState<TrashAnimation> {
  @override
  Widget build(BuildContext context) {

    var trashDim = Utils.getDimensionFromAsset(context, GameAssetOptions.cardboardbox);
    var trashWidgetOffset = ((MediaQuery.sizeOf(context).width - trashDim!.width) / trashDim.width);
    var centerTrashWidgetOffset = trashWidgetOffset / 2;

    double edgeTrashPos = getValueForScreenType(
      context: context, 
      mobile: 0.25,
      tablet: 1,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GameAssets(
          uniqueKey: Utils.cardboard,
          asset: GameAssetOptions.cardboardbox)
          .animate(
            delay: 5.seconds,
            onInit:(controller) {
              Utils.controllerMap[Utils.cardboard] = controller;
            },
          )
          .slide(
            begin: Offset(edgeTrashPos, (MediaQuery.sizeOf(context).height / trashDim.height)),
            end: Offset(edgeTrashPos, -1),
            duration: 6.5.seconds,
          ),

        GameAssets(
          uniqueKey: Utils.plasticbag,
          asset: GameAssetOptions.plasticbag)
          .animate(
            delay: 3.seconds,
            onInit:(controller) {
              Utils.controllerMap[Utils.plasticbag] = controller;
            },
            onComplete: (controller) {
              controller.repeat();
            },
          )
          .slide(
            begin: Offset(edgeTrashPos, (MediaQuery.sizeOf(context).height / trashDim.height)),
            end: Offset(edgeTrashPos, -1),
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
          begin: Offset(trashWidgetOffset - edgeTrashPos, (MediaQuery.sizeOf(context).height / trashDim.height)),
          end: Offset(trashWidgetOffset - edgeTrashPos, -1),
          duration: 5.5.seconds,
        )
      ],
    );
  }
}