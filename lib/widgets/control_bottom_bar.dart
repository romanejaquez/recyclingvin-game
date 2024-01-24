import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/laser_btn.dart';
import 'package:recyclingvin_web/widgets/move_slider.dart';

class ControlBottomBar extends ConsumerWidget {
  const ControlBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RecyclingVinStyles.largeSize),
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoveSlider(),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: RecyclingVinStyles.mediumPadding.copyWith(
                            left: RecyclingVinStyles.x3largeSize,
                          ),
                          margin: RecyclingVinStyles.xLargeMargin.copyWith(
                            top: 0, bottom: 0,
                          ),
                          height: 50,
                          decoration: BoxDecoration(
                            color: RecyclingVinColors.laserGunGreen.withOpacity(0.5),
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
                                widthFactor: 0.5,
                                child: Container(
                                  height: 10,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: RecyclingVinColors.laserGunGreen,
                                    borderRadius: BorderRadius.circular(RecyclingVinStyles.mediumSize)
                                  ),
                                ),
                                ),
                              )
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset('./assets/imgs/lasergun_sm.svg',
                          width: 90, height: 90, fit: BoxFit.contain
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
                    ],
                  )
                ),
              ),
              LaserBtn(
                onTrigger: (VinShootingOptions option) {
                  ref.read(triggerLaserProvider.notifier).state = option;
                }
              ),
          
            ],
          ),
        ],
      ),
    );
  }
}