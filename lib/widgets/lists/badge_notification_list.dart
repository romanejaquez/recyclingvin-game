import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/models/recycling_badge.model.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BadgeNotificationList extends ConsumerStatefulWidget {
  const BadgeNotificationList({super.key});

  @override
  ConsumerState<BadgeNotificationList> createState() => _BadgeNotificationListState();
}

class _BadgeNotificationListState extends ConsumerState<BadgeNotificationList> {
  List<RecyclingBadgeModel> badges = [];

  Timer inserTimer = Timer(0.seconds, () {});
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(badgeListenerProvider, (previous, next) {
      if (next == RecyclingBadgeOptions.none) {
        return;
      }

      ref.read(badgesInGameVMProvider.notifier).unlockBadge(next);
      _addTask(next);
    });

    return AnimatedList(
      key: _animatedListKey,
      initialItemCount: badges.length,
      itemBuilder: ((context, index, animation) {
        return buildBadgeItem(context, badges[index], animation, index, isAdding: true);
      })
    );
  }

  Widget buildBadgeItem(
    BuildContext context,
    RecyclingBadgeModel badgeModel, 
    Animation<double> anim, int index, { bool isAdding = false }
  ) {

    final badgeNotifLabel = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.heading6,
      tablet: RecyclingVinStyles.heading5,
    );

    final badgeNotifContent = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.heading5,
      tablet: RecyclingVinStyles.heading4,
    );

    final badgeNotifBottomContent = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.heading6,
      tablet: RecyclingVinStyles.heading5,
    );

    final badgeNotifPadding = getValueForScreenType(
      context: context, 
      mobile: const EdgeInsets.symmetric(
        horizontal: 20, vertical: 10
      ),
      tablet: const EdgeInsets.symmetric(
        horizontal: 40, vertical: 20
      ),
    );

    double badgeNotifLeftOffset = getValueForScreenType(
      context: context, 
      mobile: -80,
      tablet: -300,
    );

    double? badgeNotifRightOffset = getValueForScreenType(
      context: context, 
      mobile: 0,
      tablet: 0,
    );

    double badgeNotifDimension = getValueForScreenType(
      context: context, 
      mobile: 50,
      tablet: 100,
    );

    return Stack(
      alignment: Alignment.centerRight,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          padding: badgeNotifPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("You've unlocked the", style: badgeNotifLabel),
              Text(Utils.labelFromBadge(badgeModel.option), 
                style: badgeNotifContent.copyWith(
                  color: Utils.colorFromBadge(badgeModel.option),
                )
              ),
              Text("Badge", style: badgeNotifBottomContent),
            ],
          ),
        ),
        Positioned(
          left: badgeNotifLeftOffset,
          right: badgeNotifRightOffset,
          child: SvgPicture.asset('./assets/imgs/${badgeModel.option.name}.svg',
            width: badgeNotifDimension, height: badgeNotifDimension,
          ).animate(
            onComplete: (controller) {
              if (mounted) {
                controller.repeat(reverse: true);
              }
            },
          ).scaleXY(
            begin: 1, end: 1.25,
            curve: Curves.easeInOut,
            duration: 0.5.seconds
          ),
        )
      ],
    ).animate(
      onComplete: (controller) {
        Future.delayed(3.seconds, () {
          if (mounted) {
            controller.reverse().whenComplete(() {
              _removeTask(badgeModel);
            
              ref.read(badgesInGameVMProvider.notifier).checkIfAllBadgesObtained();
            });
          }
        });
      },
    )
    .slideX(
      begin: 1, end: 0,
      curve: Curves.easeInOut,
      duration: 0.5.seconds,
    );
  }

  void _addTask(RecyclingBadgeOptions o) async {
   var badge = RecyclingBadgeModel(
    option: o
  );
  
   badges.add(badge);
    _animatedListKey.currentState!.insertItem(badges.length - 1);
  }

  void _removeTask(RecyclingBadgeModel badge) async {
      _animatedListKey.currentState!.removeItem(badges.indexOf(badge),
    (context, animation) => const SizedBox.shrink(), duration: 0.seconds);
    badges.removeAt(badges.indexOf(badge));
  }
}