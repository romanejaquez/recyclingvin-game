import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/pages/gamepage.dart';
import 'package:recyclingvin_web/widgets/duuprgameslogo.dart';
import 'package:recyclingvin_web/widgets/splashbg.dart';
import 'package:recyclingvin_web/widgets/splashlogo.dart';
import 'package:rive/rive.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Timer splashTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    splashTimer = Timer(4.seconds, () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const GamePage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          SplashBg(),
          Center(
            child: SplashLogo(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: RecyclingVinStyles.largePadding,
              child: DuuprGamesLogo(),
            ),
          )
        ],
      )
    );
  }
}