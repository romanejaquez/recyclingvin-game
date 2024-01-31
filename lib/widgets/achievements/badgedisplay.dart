import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/models/badge_display.model.dart';

class BadgeDisplay extends StatelessWidget {

  final BadgeDisplayModel badgeModel;
  const BadgeDisplay({
    required this.badgeModel,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: RecyclingVinStyles.mediumPadding,
      child: SizedBox(
        width: 300,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('./assets/imgs/${badgeModel.badge.name}${badgeModel.isLocked ? 'lock' : ''}.svg',
                width: 200,
                height: 200,
              ),
              RecyclingVinStyles.smallGap,
              Opacity(
                opacity: badgeModel.isLocked ? 0.5 : 1,
                child: Text(badgeModel.label, textAlign: TextAlign.center, style: RecyclingVinStyles.heading3))
            ]
          ),
        ),
      ),
    );
  }
}