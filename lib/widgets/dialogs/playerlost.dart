import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class PlayerLostDialog extends StatefulWidget {
  const PlayerLostDialog({super.key});

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
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: anim,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('./assets/imgs/yesbtn.svg',
                  width: 150,
                ),
                RecyclingVinStyles.smallGap,
                SvgPicture.asset('./assets/imgs/nobtn.svg',
                  width: 150,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}