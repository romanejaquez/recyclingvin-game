import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/widgets/control_bottom_bar.dart';
import 'package:recyclingvin_web/widgets/enemy_animation.dart';
import 'package:recyclingvin_web/widgets/game_assets_anim.dart';
import 'package:recyclingvin_web/widgets/ground_animation.dart';
import 'package:recyclingvin_web/widgets/side_trees_animation.dart';
import 'package:recyclingvin_web/widgets/trash_animation.dart';
import 'package:recyclingvin_web/widgets/vin_animation.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF757575),
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),

          Positioned.fill(
            child: SvgPicture.asset('./assets/imgs/roadbg.svg',
              fit: BoxFit.fill,
            ),
          ),

          GroundAnimation(),

          SideTreesAnimation(),

          TrashAnimation(),

          Center(
            child: VinAnimation(),
          ),

          EnemyAnimation(),

          Align(
            alignment: Alignment.bottomCenter,
            child: ControlBottomBar()),
        ],
      ),
    );
  }
}