import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class DuuprGamesLogo extends StatefulWidget {

  final bool defaultLogo;
  const DuuprGamesLogo({
    this.defaultLogo = false,
    super.key
  });

  @override
  State<DuuprGamesLogo> createState() => _DuuprGamesLogoState();
}

class _DuuprGamesLogoState extends State<DuuprGamesLogo> {

  late StateMachineController ctrl;
  late RiveAnimation anim;
  String defaultLogoValue = '';
  Size defaultSize = const Size(400, 200);
  Size smallSize = const Size(250, 100);

  @override
  void initState() {
    super.initState();

    defaultLogoValue = widget.defaultLogo ? '' : '2';
    anim = RiveAnimation.direct(Utils.duuprGameStudioFile!,
      artboard: 'duuprgamestudio$defaultLogoValue',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'duuprgamestudio$defaultLogoValue')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    final logoSize = widget.defaultLogo ? defaultSize : smallSize;

    return SizedBox(
      width: logoSize.width,
      height: logoSize.height,
      child: anim
    );
  }
}