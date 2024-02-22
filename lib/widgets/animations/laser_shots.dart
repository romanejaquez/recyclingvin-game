import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LaserShots extends ConsumerStatefulWidget {
  const LaserShots({super.key});

  @override
  ConsumerState<LaserShots> createState() => _LaserShotsState();
}

class _LaserShotsState extends ConsumerState<LaserShots> {

  List<Widget> laserShotsWidget = [];
  Timer laserTimer = Timer(0.seconds, () {});
  Timer shootingTimer = Timer(0.seconds, () {});

  @override
  void dispose() {
    laserTimer.cancel();
    shootingTimer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final vinDim = Utils.getDimensionFromAsset(context, GameAssetOptions.vin)!;
    final laserLeftPos = getValueForScreenType(context: context, 
      mobile: 62.5,
      tablet: 125.0,
    );

    ref.listen(triggerLaserProvider, (previous, latest) {
        var laserOffset = vinDim.width / 2;

        if (latest == VinShootingOptions.shoot) {

          shootingTimer = Timer(const Duration(milliseconds: 500), () {
            shootingTimer.cancel();
          });

          var vinPosition = ref.read(vinPositionProvider);
          vinPosition = vinPosition ?? (MediaQuery.sizeOf(context).width / 2) - laserOffset;
        
          laserTimer.cancel();
          var laserKey = GlobalKey();

          setState(() {
            laserShotsWidget.add(
              Positioned(
                left: vinPosition! + laserLeftPos,
                child: Container(
                  key: laserKey,
                  width: 15,
                  height: 100,
                  margin: const EdgeInsets.only(
                    left: 3,
                    top: 235, 
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
          if (shootingTimer.isActive) {
            return;
          }
          
          laserTimer = Timer.periodic(100.ms, (timer) {
            var vinPosition = ref.read(vinPositionProvider);
            vinPosition = vinPosition ?? (MediaQuery.sizeOf(context).width / 2) - laserOffset;
            
            setState(() {
              var laserKey = GlobalKey();
              laserShotsWidget.add(
                Positioned(
                  key: GlobalKey(),
                  left: (vinPosition! + laserLeftPos).toDouble(),
                  child: Container(
                    key: laserKey,
                    width: 15,
                    height: 100,
                    margin: const EdgeInsets.only(
                      left: 3,
                      top: 235,
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
          shootingTimer.cancel();
        }
    });
                
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        clipBehavior: Clip.none,
        children: laserShotsWidget,
      ),
    );
  }
}
