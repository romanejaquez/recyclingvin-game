import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rive/rive.dart';

class LivesPanel extends ConsumerStatefulWidget {

  const LivesPanel({
    super.key
  });

  @override
  ConsumerState<LivesPanel> createState() => _LivesPanelState();
}

class _LivesPanelState extends ConsumerState<LivesPanel> {
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
    final livesCount = ref.watch(livesCountProvider);

    final livesLabelStyle = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.heading4,
      tablet: RecyclingVinStyles.heading1,
    );

    final livesMargin = getValueForScreenType(
      context: context,
      mobile: RecyclingVinStyles.xLargeMargin.copyWith(
        top: 0,
      ),
      tablet: EdgeInsets.zero,
    );

    return Container(
      margin: livesMargin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$livesCount', style: livesLabelStyle.copyWith(
            color: RecyclingVinColors.topGreenGradient
          )),
          SizedBox(
            width: dim.width,
            height: dim.height,
            child: anim
          ),
        ],
      ),
    );
  }
}