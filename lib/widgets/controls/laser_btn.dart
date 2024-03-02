import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rive/rive.dart';

class LaserBtn extends ConsumerStatefulWidget {

  final Function onTrigger;

  const LaserBtn({
    required this.onTrigger,
    super.key
  });

  @override
  ConsumerState<LaserBtn> createState() => _LaserBtnState();
}

class _LaserBtnState extends ConsumerState<LaserBtn> {

  late StateMachineController ctrl;
  late RiveAnimation anim;
  bool isLongPress = false;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: 'laserbtn',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'laserbtn')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {

    final canShoot = ref.watch(shootingCapabilityProvider);
    if (!canShoot) {
      Future.microtask(() {
        ref.read(triggerLaserProvider.notifier).state = VinShootingOptions.none;
      });
    }
    
    double btnDim = getValueForScreenType(
      context: context, 
      mobile: 95,
      tablet: 150,
    );

    final btnWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: btnDim,
          height: btnDim,
          child: anim
        ),
        RecyclingVinStyles.smallGap,
      ],
    );
    
    return GestureDetector(
      onTap: canShoot ? () {
        widget.onTrigger(VinShootingOptions.shoot);
      } : null,
      onLongPressDown: canShoot ? (details) {
        isLongPress = true;
        widget.onTrigger(VinShootingOptions.multishoot);
      } : null,
      onLongPressUp: canShoot ? () {
        isLongPress = false;
        widget.onTrigger(VinShootingOptions.release);
      } : null,
      child: IgnorePointer(
        ignoring: !canShoot,
        child: Opacity(
          opacity: canShoot ? 1 : 0.5,
          child: btnWidget)
      ),
    );
  }
}