import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';

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
            SvgPicture.asset('./assets/imgs/bar_can.svg',
              width: 100, height: 80, fit: BoxFit.contain,
            ),
            SvgPicture.asset('./assets/imgs/bar_bag.svg',
              width: 100, height: 80, fit: BoxFit.contain,
            )
          ],
        )
      ),
    );
  }
}