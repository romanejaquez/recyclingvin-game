import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rive/rive.dart';

class LaserBtn extends StatefulWidget {

  final Function onTrigger;

  const LaserBtn({
    required this.onTrigger,
    super.key
  });

  @override
  State<LaserBtn> createState() => _LaserBtnState();
}

class _LaserBtnState extends State<LaserBtn> {

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

    double btnDim = getValueForScreenType(
      context: context, 
      mobile: 95,
      tablet: 150,
    );
    
    return GestureDetector(
      onTap: () {
        widget.onTrigger(VinShootingOptions.shoot);
      },
      onLongPressDown:(details) {
        isLongPress = true;
        widget.onTrigger(VinShootingOptions.multishoot);
      },
      onLongPressUp: () {
        isLongPress = false;
        widget.onTrigger(VinShootingOptions.release);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: btnDim,
            height: btnDim,
            child: anim
          ),
          RecyclingVinStyles.smallGap,
        ],
      ),
    );
  }
}