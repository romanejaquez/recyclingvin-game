import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';

class LaserShots extends ConsumerStatefulWidget {
  const LaserShots({super.key});

  @override
  ConsumerState<LaserShots> createState() => _LaserShotsState();
}

class _LaserShotsState extends ConsumerState<LaserShots> {

  List<Widget> laserShotsWidget = [];
  Timer laserTimer = Timer(0.seconds, () {});
  
  @override
  Widget build(BuildContext context) {

    ref.listen(triggerLaserProvider, (previous, latest) {
        debugPrint(latest.name);

        if (latest == VinShootingOptions.shoot) {
          var vinPosition = ref.read(vinPositionProvider);
          vinPosition = vinPosition ?? (MediaQuery.sizeOf(context).width / 2) - 160;
        
          laserTimer.cancel();
          var laserKey = GlobalKey();

          setState(() {
            laserShotsWidget.add(
              Positioned(
                left: (vinPosition! - 395).toDouble(),
                child: Container(
                  key: laserKey,
                  width: 15,
                  height: 100,
                  margin: const EdgeInsets.only(
                    left: 0,
                    top: 225, 
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: RecyclingVinColors.laserLightColor,
                  ),
                ).animate(
                  onInit: (controller) {
                    controller.addListener(() {
                      Utils.checkForCollision(laserKey, Utils.enemy1, () {});
                      Utils.checkForCollision(laserKey, Utils.enemy2, () {});
                    });
                  },
                  onComplete: (controller) {
                    laserShotsWidget.removeWhere((laser) => laser.key == laserKey);
                  },
                )
                .slideY(
                  begin: 0,
                  end: 3,
                  curve: Curves.linear,
                  duration: 1.seconds,
                ),
              )
            );
          });
        }
        else if (latest == VinShootingOptions.multishoot) {
          
          laserTimer = Timer.periodic(100.ms, (timer) {
            var vinPosition = ref.read(vinPositionProvider);
            vinPosition = vinPosition ?? (MediaQuery.sizeOf(context).width / 2) - 160;
            
            setState(() {
              var laserKey = GlobalKey();
              laserShotsWidget.add(
                Positioned(
                  key: GlobalKey(),
                  left: (vinPosition! - 395).toDouble(),
                  child: Container(
                    key: laserKey,
                    width: 15,
                    height: 100,
                    margin: const EdgeInsets.only(
                      left: 0,
                      top: 225, 
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: RecyclingVinColors.laserLightColor,
                    ),
                  ).animate(
                    onInit: (controller) {
                      controller.addListener(() {
                        Utils.checkForCollision(laserKey, Utils.enemy1, () {});
                        Utils.checkForCollision(laserKey, Utils.enemy2, () {});
                      });
                    },
                    onComplete: (controller) {
                      laserShotsWidget.removeWhere((laser) => laser.key == laserKey);
                    },
                  )
                  .slideY(
                    begin: 0,
                    end: 3,
                    curve: Curves.linear,
                    duration: 1.seconds,
                  ),
                ),
              );
            });
          });
        }
        else {
          laserTimer.cancel();
        }
    });
                
    return SizedBox(
      width: 320,
      height: 320,
      child: Stack(
        clipBehavior: Clip.none,
        children: laserShotsWidget,
      ),
    );
  }
}
