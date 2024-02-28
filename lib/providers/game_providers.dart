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
final plasticBagCount = StateProvider<int>((ref) => 0);
final sodaCanCount = StateProvider<int>((ref) => 0);
final cardboardCount = StateProvider<int>((ref) => 0);

final gameStartedFlagProvider = StateProvider<bool>((ref) => false);

final onboardStepIndex = StateProvider<int>((ref) => 0);

final badgeListenerProvider = Provider((ref) {
  var badgeOption = RecyclingBadgeOptions.none;

  if (ref.watch(waterBottleCount) == 20) {
    badgeOption = RecyclingBadgeOptions.plasticPioneer;
  }

  if (ref.watch(sodaCanCount) == 20) {
    badgeOption = RecyclingBadgeOptions.canCrusher;
  }

  if (ref.watch(plasticBagCount) == 20) {
    badgeOption = RecyclingBadgeOptions.bagBuster;
  }

  return badgeOption;
});

final badgeProvider = StateProvider.autoDispose<RecyclingBadgeOptions>((ref) => RecyclingBadgeOptions.none);

final laserEnergyLevelProvider = StateProvider<double>((ref) {
  return 1;
});

final laserCalculationProvider = Provider((ref) {
  var laserValue = ref.watch(laserEnergyLevelProvider);

  if (laserValue > 1.0) {
    laserValue = 1.0;
  }
  else if (laserValue < 0.0) {
    laserValue = 0.0;
  }
  else if (laserValue >= 0.0 && laserValue <= 1.0) {
    return laserValue;
  }

  return laserValue;
});

final shootingCapabilityProvider = Provider((ref) {
  return ref.watch(laserCalculationProvider) > 0.0;
});