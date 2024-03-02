import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/lists/badge_notification_list.dart';
import 'package:recyclingvin_web/widgets/panels/lives_panel.dart';

class TopCounterBar extends StatefulWidget {
  const TopCounterBar({super.key});

  @override
  State<TopCounterBar> createState() => _TopCounterBarState();
}

class _TopCounterBarState extends State<TopCounterBar> {

  List<GlobalKey> items = [GlobalKey(),GlobalKey(),GlobalKey(),];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LivesPanel(),

              Container(
                margin: RecyclingVinStyles.mediumMargin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RecyclingVinStyles.x2largeSize),
                  color: Colors.black.withOpacity(0.2),
                ),
                width: MediaQuery.sizeOf(context).width / 2,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset('./assets/imgs/bar_waterbottle.svg',
                      width: 100, height: 80, fit: BoxFit.contain,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Transform.translate(
                          offset: const Offset(-40, 0),
                          child: Text(ref.watch(waterBottleCount).toString(), style: RecyclingVinStyles.heading3.copyWith(color: Colors.white))
                        );
                      }
                    ),
                    SvgPicture.asset('./assets/imgs/bar_can.svg',
                      width: 100, height: 80, fit: BoxFit.contain,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Transform.translate(
                          offset: const Offset(-40, 0),
                          child: Text(ref.watch(sodaCanCount).toString(), style: RecyclingVinStyles.heading3.copyWith(color: Colors.white))
                        );
                      }
                    ),
                    SvgPicture.asset('./assets/imgs/bar_bag.svg',
                      width: 100, height: 80, fit: BoxFit.contain,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Transform.translate(
                          offset: const Offset(-40, 0),
                          child: Text(ref.watch(plasticBagCount).toString(), style: RecyclingVinStyles.heading3.copyWith(color: Colors.white))
                        );
                      }
                    ),
                  ],
                )
              ),
            ],
          ),

          RecyclingVinStyles.smallGap,

          const SizedBox(
            width: 300,
            height: 300,
            child: BadgeNotificationList()
          ),
        ],
      ),
    );
  }
}