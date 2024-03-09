import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LaserEnergyLevel extends ConsumerStatefulWidget {
  const LaserEnergyLevel({super.key});

  @override
  ConsumerState<LaserEnergyLevel> createState() => _LaserEnergyLevelState();
}

class _LaserEnergyLevelState extends ConsumerState<LaserEnergyLevel> {
  
  Timer laserLevelTimer = Timer(0.seconds, () {});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double laserGunDim = getValueForScreenType(
      context: context, 
      mobile: 60,
      tablet: 90,
    );

    final laserGunMargin = getValueForScreenType(
      context: context, 
      mobile: const EdgeInsets.only(left: 40),
      tablet: EdgeInsets.zero,
    );

    final laserGunLabelStyle = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.subHeading5,
      tablet: RecyclingVinStyles.subHeading4,
    );

    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Consumer(
              builder: (context, ref, child) {

                final laserLevel = ref.watch(laserCalculationProvider);
                final laserLabelValue = (laserLevel * 100).round();
                final laserLevelColor = Utils.getColorPerLaserLevel(laserLevel);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: RecyclingVinStyles.mediumPadding.copyWith(
                        left: RecyclingVinStyles.x3largeSize,
                      ),
                      margin: RecyclingVinStyles.xLargeMargin.copyWith(
                        top: RecyclingVinStyles.smallSize, bottom: 0,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        color: laserLevelColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(RecyclingVinStyles.mediumSize)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(RecyclingVinStyles.mediumSize)
                        ),
                        child: Container(
                          margin: RecyclingVinStyles.xsmallMargin,
                          alignment: Alignment.topLeft,
                          child: FractionallySizedBox(
                            widthFactor: laserLevel,
                            child: Container(
                              height: 10,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: laserLevelColor,
                                borderRadius: BorderRadius.circular(RecyclingVinStyles.mediumSize)
                              ),
                            ),
                          ),
                        )
                      ),
                    ),
                    RecyclingVinStyles.x2smallGap,
                    Container(
                      margin: const EdgeInsets.only(right: RecyclingVinStyles.xlargeSize * 2),
                      child: Text('$laserLabelValue% Level', style: laserGunLabelStyle.copyWith(
                        color: laserLevelColor,
                      ))
                    )
                  ],
                );
              }
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: laserGunMargin,
              child: SvgPicture.asset('./assets/imgs/lasergun_sm.svg',
                width: laserGunDim, height: laserGunDim, fit: BoxFit.contain
              ).animate(
                onComplete: (controller) {
                  controller.repeat(reverse: true);
                },
              ).slideY(
                begin: -0.15, end: 0.15,
                curve: Curves.easeInOut,
                duration: 2.seconds,
              ),
            ),
          ),
        ],
      )
    );
  }
}