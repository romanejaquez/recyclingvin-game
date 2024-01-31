import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/models/badge_display.model.dart';

class BadgesRepository {

  List<BadgeDisplayModel> getBadges() {
    return [
      BadgeDisplayModel(
        badge: RecyclingBadgeOptions.bagBuster,
        label: Utils.labelFromBadge(RecyclingBadgeOptions.bagBuster)
      ),
      BadgeDisplayModel(
        badge: RecyclingBadgeOptions.canCrusher,
        label: Utils.labelFromBadge(RecyclingBadgeOptions.canCrusher)
      ),
      BadgeDisplayModel(
        badge: RecyclingBadgeOptions.plasticPioneer,
        label: Utils.labelFromBadge(RecyclingBadgeOptions.plasticPioneer)
      )
    ];
  }
}