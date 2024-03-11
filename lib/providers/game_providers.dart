import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/constants.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/models/badge_display.model.dart';
import 'package:recyclingvin_web/repositories/badgeachievements.repository.dart';
import 'package:recyclingvin_web/repositories/badges.repository.dart';
import 'package:recyclingvin_web/repositories/onboardingsteps.repository.dart';
import 'package:recyclingvin_web/services/audio_service.dart';
import 'package:recyclingvin_web/services/badgepersistence_service.dart';
import 'package:recyclingvin_web/services/game_loop_service.dart';
import 'package:recyclingvin_web/viewmodels/badgedisplay.viewmodel.dart';
import 'package:recyclingvin_web/viewmodels/badgescollected.viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final audioSoundProvider = Provider((ref) {
  return AudioService();
});

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

final badgesCollectedVMProvider = StateNotifierProvider<BadgesCollectedViewModel, List<BadgeDisplayModel>>((ref) {
  var badges = ref.read(badgeRepositoryProvider).getBadges();
  final storedBadgesMetadata = ref.read(badgeStorageProvider).getBadgesAchievedConfig();
  List<RecyclingBadgeOptions> storedBadges = [];
  
  if (storedBadgesMetadata.isNotEmpty) {
    var storedBadgeTokens = storedBadgesMetadata.split(',');
    
    storedBadges = storedBadgeTokens.where((s) => s.isNotEmpty).map(
      (s) => RecyclingBadgeOptions.values.firstWhere((element) => element.name == s.trim())
    ).toList();
  }

  if (storedBadges.isNotEmpty) {
    badges = badges.map((b) => b.copyWith(
      isLocked: !storedBadges.contains(b.badge),
    )).toList();
  }

  return BadgesCollectedViewModel(badges, ref);
});

final badgesInGameVMProvider = StateNotifierProvider<BadgeDisplayViewModel, List<BadgeDisplayModel>>((ref) {
  var badges = ref.read(badgeRepositoryProvider).getBadges();

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

  if (ref.watch(waterBottleCount) == Constants.waterBottleGoal) {
    badgeOption = RecyclingBadgeOptions.plasticPioneer;
  }

  if (ref.watch(sodaCanCount) == Constants.sodaCanGoal) {
    badgeOption = RecyclingBadgeOptions.canCrusher;
  }

  if (ref.watch(plasticBagCount) == Constants.plasticBagGoal) {
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

final livesCountProvider = StateProvider((ref) => Constants.defaultLives);

final sharedPrefsInstanceProvider = Provider((ref) {
  return SharedPreferences.getInstance();
});

final sharedPrefsLoaderProvider = FutureProvider<SharedPreferences>((ref) async {
  final prefs = await ref.read(sharedPrefsInstanceProvider);
  return prefs;
});

final badgeStorageProvider = Provider((ref) {
  return BadgePersistenceService(ref);
});

final gameWonProvider = StateProvider((ref) => false);