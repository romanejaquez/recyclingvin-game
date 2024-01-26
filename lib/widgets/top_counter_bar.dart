import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';

class TopCounterBar extends StatelessWidget {
  const TopCounterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                  child: Text(ref.watch(trashBagCount).toString(), style: RecyclingVinStyles.heading3.copyWith(color: Colors.white))
                );
              }
            ),
          ],
        )
      ),
    );
  }
}