import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/control_bottom_bar.dart';
import 'package:recyclingvin_web/widgets/enemy_animation.dart';
import 'package:recyclingvin_web/widgets/game_assets_anim.dart';
import 'package:recyclingvin_web/widgets/ground_animation.dart';
import 'package:recyclingvin_web/widgets/side_trees_animation.dart';
import 'package:recyclingvin_web/widgets/top_counter_bar.dart';
import 'package:recyclingvin_web/widgets/trash_animation.dart';
import 'package:recyclingvin_web/widgets/vin_animation.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {

  Timer loopTimer = Timer(0.seconds, () {});

  @override
  void initState() {
    super.initState();

    loopTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Utils.checkForCollision(Utils.vin1, Utils.cardboard, () {
        
      });

      Utils.checkForCollision(Utils.vin1, Utils.waterBottle, () {
        ref.read(waterBottleCount.notifier).state += 1;
      });

      Utils.checkForCollision(Utils.vin1, Utils.sodaCan, () {
        ref.read(sodaCanCount.notifier).state += 1;
      });

      Utils.checkForCollision(Utils.vin1, Utils.enemy1, () {
        
      });

      Utils.checkForCollision(Utils.vin1, Utils.enemy2, () {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF398F00),
                  Color(0xFF193F00),
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

          Consumer(
            builder: (context, ref, child) {
              return Positioned(
                top: MediaQuery.sizeOf(context).height / 3,
                left: ref.watch(vinPositionProvider) ?? (MediaQuery.sizeOf(context).width / 2) - 160,
                child: Stack(
                  children: [
                    Center(child: VinAnimation()),
                    Consumer(
                      builder:(context, ref, child) {
                                
                        final shootLaser = ref.watch(triggerLaserProvider);
                                
                        return Center(
                          key: ValueKey(shootLaser),
                          child: Container(
                            width: 15,
                            height: 100,
                            margin: EdgeInsets.only(top: 200, right: 55),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xFFEFFF3B).withOpacity(0.75),
                            ),
                          ).animate()
                          .slideY(
                            begin: 0,
                            end: 3,
                            curve: Curves.linear,
                            duration: 1.seconds,
                          ),
                        );
                      }
                    )
                  ],
                ),
              );
            }
          ),

          EnemyAnimation(),

          Align(
            alignment: Alignment.bottomCenter,
            child: ControlBottomBar()
          ),

          Align(
            alignment: Alignment.topRight,
            child: TopCounterBar(),
          )
        ],
      ),
    );
  }
}