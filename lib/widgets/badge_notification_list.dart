import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/models/recycling_badge.model.dart';

class BadgeNotificationList extends StatefulWidget {
  const BadgeNotificationList({super.key});

  @override
  State<BadgeNotificationList> createState() => _BadgeNotificationListState();
}

class _BadgeNotificationListState extends State<BadgeNotificationList> {
  List<RecyclingBadgeModel> badges = [];

  Timer inserTimer = Timer(0.seconds, () {});
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    inserTimer = Timer(3.seconds, () {
      _addTask(RecyclingBadgeOptions.bagBuster);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _animatedListKey,
      initialItemCount: badges.length,
      itemBuilder: ((context, index, animation) {
        return buildBadgeItem(badges[index], animation, index, isAdding: true);
      })
    );
  }

  Widget buildBadgeItem(
    RecyclingBadgeModel badgeModel, Animation<double> anim, int index, { bool isAdding = false }) {
    return GestureDetector(
      onTap: () {
        //_removeTask(badgeModel);
      },
      child: Stack(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
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
                Text("You've unlocked the", style: RecyclingVinStyles.heading5),
                Text(Utils.labelFromBadge(badgeModel.option), 
                  style: RecyclingVinStyles.heading3.copyWith(
                    color: Utils.colorFromBadge(badgeModel.option),
                  )
                ),
                Text("Badge", style: RecyclingVinStyles.heading5),
              ],
            ),
          ),
          Positioned(
            left: -50,
            child: SvgPicture.asset('./assets/imgs/${badgeModel.option.name}.svg',
              width: 100, height: 100,
            ).animate(
              onComplete: (controller) {
                controller.repeat(reverse: true);
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
              // Future.delayed((index + 1).seconds, () {
              //   controller.reverse().whenComplete(() {
              //     //_removeTask(badgeModel);
              //   });
              // });
            },
          )
          .slideX(
            begin: 1, end: 0,
            curve: Curves.easeInOut,
            duration: 0.5.seconds,
          ),
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