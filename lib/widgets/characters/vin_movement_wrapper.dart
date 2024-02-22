import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/characters/vin_animation.dart';

class VinMovementWrapper extends StatelessWidget {
  const VinMovementWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {

        final vinDim = Utils.getDimensionFromAsset(context, GameAssetOptions.vin)!;
    
        return Positioned(
          top: MediaQuery.sizeOf(context).height / 3,
          left: ref.watch(vinPositionProvider) ?? (MediaQuery.sizeOf(context).width / 2) - vinDim.width / 2,
          child: const VinAnimation()
        );
      }
    );
  }
}