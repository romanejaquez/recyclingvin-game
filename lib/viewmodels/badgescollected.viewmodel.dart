import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/models/badge_display.model.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';

class BadgesCollectedViewModel extends StateNotifier<List<BadgeDisplayModel>> {

  final Ref ref;

  BadgesCollectedViewModel(super.state, this.ref);

  void unlockBadge(RecyclingBadgeOptions option) {
    state = [
      for(var badge in state)
        if (badge.badge == option)
          badge.copyWith(isLocked: false)
        else
          badge
    ];

    ref.read(badgeStorageProvider).storeBadgesAchievedConfig(option.name);
  }
}