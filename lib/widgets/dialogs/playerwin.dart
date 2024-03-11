import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/controls/yesno_btn.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rive/rive.dart';

class PlayerWinDialog extends ConsumerStatefulWidget {

  final Function onSelection;
  const PlayerWinDialog({
    required this.onSelection,
    super.key
  });

  @override
  ConsumerState<PlayerWinDialog> createState() => _PlayerWinDialogState();
}

class _PlayerWinDialogState extends ConsumerState<PlayerWinDialog> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'vinbadge',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'vinbadge')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {

    double playerWinBadgeSize = getValueForScreenType(
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
              width: playerWinBadgeSize,
              height: playerWinBadgeSize,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('./assets/imgs/bagBuster.svg',
                  width: 80, height: 80, fit: BoxFit.contain,
                ),
                const SizedBox(width: RecyclingVinStyles.smallSize),
                SvgPicture.asset('./assets/imgs/canCrusher.svg',
                  width: 80, height: 80, fit: BoxFit.contain,
                ),
                const SizedBox(width: RecyclingVinStyles.smallSize),
                SvgPicture.asset('./assets/imgs/plasticPioneer.svg',
                  width: 80, height: 80, fit: BoxFit.contain,
                )
              ].animate(
                delay: 0.75.seconds,
                interval: 100.ms,
              ).scaleXY(
                begin: 0.5, end: 1,
                curve: Curves.easeInOut,
                duration: 0.25.seconds,
              ).fadeIn(
                curve: Curves.easeInOut,
                duration: 0.25.seconds,
              ),
            ),
            RecyclingVinStyles.smallGap,
            Text('YOU WIN!', style: RecyclingVinStyles.heading1.copyWith(
              color: RecyclingVinColors.vinGreen,
            )),
            RecyclingVinStyles.smallGap,
            Text('Play again?', style: RecyclingVinStyles.heading4.copyWith(
              color: Colors.white
            )),
            RecyclingVinStyles.smallGap,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                YesNoBtn(
                  buttonOption: YesNoButtonOptions.yesbtn, 
                  onTap: () {
                    ref.read(audioSoundProvider).playSound(RecyclingVinSounds.click);
                    widget.onSelection(PlayerDialogSelection.yes);
                  }
                ),
                const SizedBox(width: RecyclingVinStyles.xsmallSize),
                YesNoBtn(
                  buttonOption: YesNoButtonOptions.nobtn, 
                  onTap: () {
                    ref.read(audioSoundProvider).playSound(RecyclingVinSounds.click);
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