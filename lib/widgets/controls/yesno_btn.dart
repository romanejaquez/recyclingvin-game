import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rive/rive.dart';

class YesNoBtn extends StatefulWidget {

  final YesNoButtonOptions buttonOption;
  final VoidCallback onTap;

  const YesNoBtn({
    required this.buttonOption,
    required this.onTap,
    super.key});

  @override
  State<YesNoBtn> createState() => _YesNoButtonState();
}

class _YesNoButtonState extends State<YesNoBtn> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.gameAssetsFile!,
      artboard: widget.buttonOption.name,
      onInit: onRiveInit,
      fit: BoxFit.fitWidth,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, widget.buttonOption.name)!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {

    double yesNoBtnHeight = getValueForScreenType(
      context: context, 
      mobile: 70,
      tablet: 80,
    );

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 140,
        height: yesNoBtnHeight,
        child: anim
      ),
    );
  }
}