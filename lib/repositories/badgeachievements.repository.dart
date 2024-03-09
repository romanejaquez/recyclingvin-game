import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/models/badge_achievement_metadata.model.dart';
import 'package:uuid/uuid.dart';

class BadgeAchievementsRepository {

  static const String _issuerId = '3388000000022314022';
  static const String _issuerEmail = 'romanejaquez@gmail.com';

  Map<RecyclingBadgeOptions, BadgeAchievementMetadata> getBadgeAchievementsMetadata() {
    return {
      RecyclingBadgeOptions.bagBuster: BadgeAchievementMetadata(
        badgeColorHex: '#F9BC15',
        badgeOption: RecyclingBadgeOptions.bagBuster,
        id: 'bag-buster-badge', //const Uuid().v4(),
        issuerId: BadgeAchievementsRepository._issuerId,
        issuerEmail: BadgeAchievementsRepository._issuerEmail,
        walletId: 'bag-buster-badge',
        imgName: 'badgebagbuster'
      ),
      RecyclingBadgeOptions.canCrusher: BadgeAchievementMetadata(
        badgeColorHex: '#920000',
        badgeOption: RecyclingBadgeOptions.canCrusher,
        id: 'can-crusher-badge', //const Uuid().v4(),
        issuerId: BadgeAchievementsRepository._issuerId,
        issuerEmail: BadgeAchievementsRepository._issuerEmail,
        walletId: 'can-crusher-badge',
        imgName: 'badgecancrusher'
      ),
      RecyclingBadgeOptions.plasticPioneer: BadgeAchievementMetadata(
        badgeColorHex: '#015466',
        badgeOption: RecyclingBadgeOptions.plasticPioneer,
        id: 'plastic-pioneer-badge', // const Uuid().v4(),
        issuerId: BadgeAchievementsRepository._issuerId,
        issuerEmail: BadgeAchievementsRepository._issuerEmail,
        walletId: 'plastic-pioneer-badge',
        imgName: 'badgeplasticpioneer'
      ),
    };
  }
}