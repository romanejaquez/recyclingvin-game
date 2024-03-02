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
  Timer innerLaserTimer = Timer(0.seconds, () {});
  Timer shootingTimer = Timer(0.seconds, () {});

  @override
  void dispose() {
    laserTimer.cancel();
    shootingTimer.cancel();
    innerLaserTimer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final vinDim = Utils.getDimensionFromAsset(context, GameAssetOptions.vin)!;

    final laserLeftOffset = getValueForScreenType(context: context, 
      mobile: 60,
      tablet: 125.0,
    );

    final laserPoint = getValueForScreenType(context: context, 
      mobile: const Offset(0, 125),
      tablet: const Offset(3, 235)
    );

    final laserDim = getValueForScreenType(context: context, 
      tablet: const Size(15, 100),
      mobile: const Size(7, 50),
    );

    final canShoot = ref.watch(shootingCapabilityProvider);

    ref.listen(triggerLaserProvider, (previous, latest) {

        if (!canShoot) {
          laserTimer.cancel();
          shootingTimer.cancel();
          innerLaserTimer.cancel();
          laserShotsWidget.clear();
          return;
        }

        var laserOffset = vinDim.width / 2;

        if (latest == VinShootingOptions.shoot) {

          laserTimer.cancel();
          
          // reduce the lasershot energy level
          ref.read(laserEnergyLevelProvider.notifier).state = 
            ref.read(laserEnergyLevelProvider.notifier).state - 0.01;

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
                left: vinPosition! + laserLeftOffset,
                child: Container(
                  key: laserKey,
                  width: laserDim.width,
                  height: laserDim.height,
                  margin: EdgeInsets.only(
                    left: laserPoint.dx,
                    top: laserPoint.dy, 
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
            
            ref.read(laserEnergyLevelProvider.notifier).state = 
              ref.read(laserEnergyLevelProvider.notifier).state - 0.01;
            
            setState(() {
              var laserKey = GlobalKey();
              laserShotsWidget.add(
                Positioned(
                  key: GlobalKey(),
                  left: (vinPosition! + laserLeftOffset).toDouble(),
                  child: Container(
                    key: laserKey,
                    width: laserDim.width,
                    height: laserDim.height,
                    margin: EdgeInsets.only(
                      left: laserPoint.dx,
                      top: laserPoint.dy,
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
          innerLaserTimer.cancel();
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
