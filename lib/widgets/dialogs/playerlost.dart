import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/widgets/controls/yesno_btn.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rive/rive.dart';

class PlayerLostDialog extends StatefulWidget {

  final Function onSelection;
  const PlayerLostDialog({
    required this.onSelection,
    super.key
  });

  @override
  State<PlayerLostDialog> createState() => _PlayerLostDialogState();
}

class _PlayerLostDialogState extends State<PlayerLostDialog> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'cryingvinbadge',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'cryingvinbadge')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {

    double playerLostBadgeSize = getValueForScreenType(
      context: context, 
      mobile: 300,
      tablet: 400,
    );

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: playerLostBadgeSize,
              height: playerLostBadgeSize,
              child: anim,
            ).animate(
              delay: 0.125.seconds
            )
            .scaleXY(
              begin: 0.5, end: 1,
              curve: Curves.easeInOut,
              duration: 0.25.seconds,
            ).fadeIn(
              curve: Curves.easeInOut,
              duration: 0.25.seconds,
            ),
            Text('YOU LOST!', style: RecyclingVinStyles.heading1.copyWith(
              color: Colors.white
            )),
            RecyclingVinStyles.smallGap,
            Text('Try again?', style: RecyclingVinStyles.heading4.copyWith(
              color: Colors.white
            )),
            RecyclingVinStyles.smallGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                YesNoBtn(
                  buttonOption: YesNoButtonOptions.yesbtn, 
                  onTap: () {
                    widget.onSelection(PlayerDialogSelection.yes);
                  }
                ),
                const SizedBox(width: RecyclingVinStyles.xsmallSize),
                YesNoBtn(
                  buttonOption: YesNoButtonOptions.nobtn, 
                  onTap: () {
                    widget.onSelection(PlayerDialogSelection.no);
                  }
                ),
              ].animate(
                onComplete:(controller) {
                  controller.repeat(reverse: true);
                },
                interval: 0.25.seconds, 
              ).slideY(
                begin: 0, end: 0.25,
                curve: Curves.easeInOut,
                duration: 1.seconds
              ),
            )
          ],
        ),
      ),
    );
  }
}