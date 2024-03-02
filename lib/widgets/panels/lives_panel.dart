import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class LivesPanel extends StatefulWidget {

  const LivesPanel({
    super.key
  });

  @override
  State<LivesPanel> createState() => _LivesPanelState();
}

class _LivesPanelState extends State<LivesPanel> {
  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'vinheart',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'vinheart')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {

    final dim = Utils.getDimensionFromAsset(context, GameAssetOptions.vinheart)!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('3', style: RecyclingVinStyles.heading1.copyWith(
          color: RecyclingVinColors.topGreenGradient
        )),
        SizedBox(
          width: dim.width,
          height: dim.height,
          child: anim
        ),
      ],
    );
  }
}