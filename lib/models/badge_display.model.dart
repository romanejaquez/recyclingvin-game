import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/models/badge_achievement_metadata.model.dart';

class BadgeDisplayModel {

  final RecyclingBadgeOptions badge;
  final bool isLocked;
  final String label;
  final BadgeAchievementMetadata metadata;

  const BadgeDisplayModel({
    required this.badge,
    this.isLocked = true,
    required this.label,
    required this.metadata,
  });

  BadgeDisplayModel copyWith({
    RecyclingBadgeOptions? badge,
    bool? isLocked,
    String? label
  }) {
    return BadgeDisplayModel(
      badge: badge ?? this.badge, 
      label: label ?? this.label,
      isLocked: isLocked ?? this.isLocked,
      metadata: metadata ??  this.metadata,
    );
  }
}