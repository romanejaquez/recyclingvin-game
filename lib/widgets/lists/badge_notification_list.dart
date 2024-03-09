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

      ref.read(badgesVMProvider.notifier).unlockBadge(next);
      _addTask(next);
    });

    return AnimatedList(
      key: _animatedListKey,
      initialItemCount: badges.length,
      itemBuilder: ((context, index, animation) {
        return buildBadgeItem(badges[index], animation, index, isAdding: true);
      })
    );
  }

  Widget buildBadgeItem(
    RecyclingBadgeModel badgeModel, 
    Animation<double> anim, int index, { bool isAdding = false }
  ) {
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
          padding: const EdgeInsets.only(
            left: 40, top: 20, bottom: 20, right: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("You've unlocked the", style: RecyclingVinStyles.heading5),
              Text(Utils.labelFromBadge(badgeModel.option), 
                style: RecyclingVinStyles.heading4.copyWith(
                  color: Utils.colorFromBadge(badgeModel.option),
                )
              ),
              const Text("Badge", style: RecyclingVinStyles.heading5),
            ],
          ),
        ),
        Positioned(
          left: -50,
          child: SvgPicture.asset('./assets/imgs/${badgeModel.option.name}.svg',
            width: 100, height: 100,
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
            
              ref.read(badgesVMProvider.notifier).checkIfAllBadgesObtained();
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