import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class GameAssets extends StatefulWidget {

  final GameAssetOptions asset;
  const GameAssets({
    required this.asset,
    super.key
  });

  @override
  State<GameAssets> createState() => _GameAssetsState();
}

class _GameAssetsState extends State<GameAssets> {
  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: widget.asset.name,
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, widget.asset.name)!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {

    final dim = Utils.getDimensionFromAsset(widget.asset);
    return SizedBox(
      width: dim.width,
      height: dim.height,
      child: anim
    );
  }
}