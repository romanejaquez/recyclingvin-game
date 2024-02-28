import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/models/badge_display.model.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/repositories/badgeachievements.repository.dart';

class BadgesRepository {

  final Ref ref;

  const BadgesRepository(this.ref);

  List<BadgeDisplayModel> getBadges() {

    BadgeAchievementsRepository achievements = ref.read(badgeAchievementsRepositoryProvider);
    var achievementsMapping = achievements.getBadgeAchievementsMetadata();

    return [
      BadgeDisplayModel(
        isLocked: true,
        badge: RecyclingBadgeOptions.bagBuster,
        label: Utils.labelFromBadge(RecyclingBadgeOptions.bagBuster),
        metadata: achievementsMapping[RecyclingBadgeOptions.bagBuster]!,
      ),
      BadgeDisplayModel(
        isLocked: true,
        badge: RecyclingBadgeOptions.canCrusher,
        label: Utils.labelFromBadge(RecyclingBadgeOptions.canCrusher),
        metadata: achievementsMapping[RecyclingBadgeOptions.canCrusher]!,
      ),
      BadgeDisplayModel(
        isLocked: true,
        badge: RecyclingBadgeOptions.plasticPioneer,
        label: Utils.labelFromBadge(RecyclingBadgeOptions.plasticPioneer),
        metadata: achievementsMapping[RecyclingBadgeOptions.plasticPioneer]!,
      )
    ];
  }
}