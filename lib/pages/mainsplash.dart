import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/pages/splashpage.dart';
import 'package:rive/rive.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {

  Timer mainSplashTimer = Timer(0.seconds, () {});

  @override
  void initState() {
    super.initState();

    preloadFile();
  }

  Future<void> preloadFile() async {

    Utils.mainFile = RiveFile.import(await rootBundle.load('./assets/anims/recyclingvin.riv'));
    Utils.gameAssetsFile = RiveFile.import(await rootBundle.load('./assets/anims/recyclingvin_game_assets.riv'));
    Utils.duuprGameStudioFile = RiveFile.import(await rootBundle.load('./assets/anims/duuprgamestudio.riv'));
    
    mainSplashTimer = Timer(3.seconds, () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SplashPage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: Center(
        child: SvgPicture.asset('./assets/imgs/duupr_game_studio.svg',
          width: 300, height: 150, fit: BoxFit.contain,
        ),
      )
    );
  }
}