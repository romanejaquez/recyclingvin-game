import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:rive/rive.dart';

class DuuprGamesLogo extends StatefulWidget {
  const DuuprGamesLogo({super.key});

  @override
  State<DuuprGamesLogo> createState() => _DuuprGamesLogoState();
}

class _DuuprGamesLogoState extends State<DuuprGamesLogo> {

  late StateMachineController ctrl;
  late RiveAnimation anim;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.direct(Utils.duuprGameStudioFile!,
      artboard: 'duuprgamestudio2',
      onInit: onRiveInit,
      fit: BoxFit.contain,
    );
  }

  void onRiveInit(Artboard ab) {
    ctrl = StateMachineController.fromArtboard(ab, 'duuprgamestudio2')!;
    ab.addController(ctrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 150,
      child: anim
    );
  }
}