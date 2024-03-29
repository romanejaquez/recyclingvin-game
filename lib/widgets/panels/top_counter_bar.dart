import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/lists/badge_notification_list.dart';
import 'package:recyclingvin_web/widgets/panels/lives_panel.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TopCounterBar extends StatefulWidget {
  const TopCounterBar({super.key});

  @override
  State<TopCounterBar> createState() => _TopCounterBarState();
}

class _TopCounterBarState extends State<TopCounterBar> {

  List<GlobalKey> items = [GlobalKey(),GlobalKey(),GlobalKey(),];

  @override
  Widget build(BuildContext context) {

    final trashDim = getValueForScreenType(
      context: context, 
      mobile: const Size(50, 40),
      tablet: const Size(100, 80),
    );

    final trashColumnAlign = getValueForScreenType(
      context: context, 
      mobile: CrossAxisAlignment.stretch,
      tablet: CrossAxisAlignment.end,
    );

    double trashIconOffset = getValueForScreenType(
      context: context, 
      mobile: -20,
      tablet: -40,
    );

    final trashCountLabel = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.heading5,
      tablet: RecyclingVinStyles.heading3,
    );

    double trashCountTopBarWidth = getValueForScreenType(
      context: context, 
      mobile: 1.25,
      tablet: 2,
    );

    double trashCountTopBarHeight = getValueForScreenType(
      context: context, 
      mobile: 50,
      tablet: 80,
    );

    final trashCountTopBarMargin = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.smallMargin,
      tablet: RecyclingVinStyles.mediumMargin,
    );

    bool showLivesPanel = getValueForScreenType(
      context: context, 
      mobile: false,
      tablet: true,
    );

    double unlockedBadgeSize = getValueForScreenType(
      context: context, 
      mobile: 24,
      tablet: 40,
    );

    double unlockedBadgeOffset = getValueForScreenType(
      context: context, 
      mobile: -20,
      tablet: -30,
    );

    return SafeArea(
      child: Column(
        crossAxisAlignment: trashColumnAlign,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: showLivesPanel,
                child: const LivesPanel()
              ),
              Container(
                margin: trashCountTopBarMargin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RecyclingVinStyles.x2largeSize),
                  color: Colors.black.withOpacity(0.2),
                ),
                width: MediaQuery.sizeOf(context).width / trashCountTopBarWidth,
                height: trashCountTopBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset('./assets/imgs/bar_waterbottle.svg',
                          width: trashDim.width, height: trashDim.height, fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: unlockedBadgeOffset,
                          child: Consumer(
                            builder: (context, ref, child) {
                              return Visibility(
                                visible: ref.watch(checkForUnlockedBadge(RecyclingBadgeOptions.plasticPioneer)),
                                child: SvgPicture.asset('./assets/imgs/plasticPioneer.svg',
                                  width: unlockedBadgeSize, height: unlockedBadgeSize, fit: BoxFit.contain,
                                ),
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Transform.translate(
                          offset: Offset(trashIconOffset, 0),
                          child: Text(ref.watch(waterBottleCount).toString(),
                            style: trashCountLabel.copyWith(color: Colors.white))
                        );
                      }
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset('./assets/imgs/bar_can.svg',
                          width: trashDim.width, height: trashDim.height, fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: unlockedBadgeOffset,
                          child: Consumer(
                            builder: (context, ref, child) {
                              return Visibility(
                                visible: ref.watch(checkForUnlockedBadge(RecyclingBadgeOptions.canCrusher)),
                                child: SvgPicture.asset('./assets/imgs/canCrusher.svg',
                                  width: unlockedBadgeSize, height: unlockedBadgeSize, fit: BoxFit.contain,
                                ),
                              );
                            }
                          ),
                        ),
                      ]
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Transform.translate(
                          offset: Offset(trashIconOffset, 0),
                          child: Text(ref.watch(sodaCanCount).toString(),
                            style: trashCountLabel.copyWith(color: Colors.white))
                        );
                      }
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset('./assets/imgs/bar_bag.svg',
                          width: trashDim.width, height: trashDim.height,  fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: unlockedBadgeOffset,
                          child: Consumer(
                            builder: (context, ref, child) {
                              return Visibility(
                                visible: ref.watch(checkForUnlockedBadge(RecyclingBadgeOptions.bagBuster)),
                                child: SvgPicture.asset('./assets/imgs/bagBuster.svg',
                                  width: unlockedBadgeSize, height: unlockedBadgeSize, fit: BoxFit.contain,
                                ),
                              );
                            }
                          ),
                        ),
                      ]
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Transform.translate(
                          offset: Offset(trashIconOffset, 0),
                          child: Text(ref.watch(plasticBagCount).toString(),
                            style: trashCountLabel.copyWith(color: Colors.white))
                        );
                      }
                    ),
                  ],
                )
              ),
            ],
          ),

          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                  visible: !showLivesPanel,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LivesPanel(),
                    ],
                  ),
                ),
              ),
              
              
              const Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: BadgeNotificationList()
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}