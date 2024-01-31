import 'package:recyclingvin_web/helpers/enums.dart';

class BadgeDisplayModel {

  final RecyclingBadgeOptions badge;
  final bool isLocked;
  final String label;

  const BadgeDisplayModel({
    required this.badge,
    this.isLocked = true,
    required this.label,
  });

  BadgeDisplayModel copyWith({
    RecyclingBadgeOptions? badge,
    bool? isLocked,
    String? label
  }) {
    return BadgeDisplayModel(
      badge: badge ?? this.badge, 
      label: label ?? this.label,
      isLocked: isLocked ?? this.isLocked
    );
  }
}