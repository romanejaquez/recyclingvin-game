import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/models/badge_display.model.dart';
import 'package:recyclingvin_web/repositories/badgeachievements.repository.dart';
import 'package:recyclingvin_web/repositories/badges.repository.dart';
import 'package:recyclingvin_web/repositories/onboardingsteps.repository.dart';
import 'package:recyclingvin_web/services/game_loop_service.dart';
import 'package:recyclingvin_web/viewmodels/badgedisplay.viewmodel.dart';

final gameLoopProvider = Provider((ref) {
  return GameLoopService(ref);
});

final onboardingStepsProvider = Provider((ref) {
  return OnboardingStepsRepository();
});

final badgeAchievementsRepositoryProvider = Provider((ref) {
  return BadgeAchievementsRepository();
});

final badgeRepositoryProvider = Provider((ref) {
  return BadgesRepository(ref);
});

final badgesVMProvider = StateNotifierProvider<BadgeDisplayViewModel, List<BadgeDisplayModel>>((ref) {
  final badges = ref.read(badgeRepositoryProvider).getBadges();
  return BadgeDisplayViewModel(badges, ref);
});

final triggerLaserProvider = StateProvider.autoDispose<VinShootingOptions>((ref) => VinShootingOptions.none);

final vinPositionProvider = StateProvider<double?>((ref) => null);

final waterBottleCount = StateProvider<int>((ref) => 0);
final sodaCanCount = StateProvider<int>((ref) => 0);
final trashBagCount = StateProvider<int>((ref) => 0);
final cardboardCount = StateProvider<int>((ref) => 0);

final gameStartedFlagProvider = StateProvider<bool>((ref) => false);

final onboardStepIndex = StateProvider<int>((ref) => 0);

final badgeListenerProvider = Provider((ref) {
  var badgeOption = RecyclingBadgeOptions.none;

  if (ref.watch(waterBottleCount) == 40) {
    badgeOption = RecyclingBadgeOptions.plasticPioneer;
  }

  if (ref.watch(sodaCanCount) == 60) {
    badgeOption = RecyclingBadgeOptions.canCrusher;
  }

  if (ref.watch(cardboardCount) == 80) {
    badgeOption = RecyclingBadgeOptions.bagBuster;
  }

  return badgeOption;
});

final badgeProvider = StateProvider.autoDispose<RecyclingBadgeOptions>((ref) => RecyclingBadgeOptions.none);

final laserEnergyLevelProvider = StateProvider<double>((ref) {
  return 25.0;
});

final laserCalculationProvider = Provider((ref) {
  var laserValue = ref.watch(laserEnergyLevelProvider);
  if (laserValue <= 1.0) {
    return laserValue;
  }
  return 1.0;
});