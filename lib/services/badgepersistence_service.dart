import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgePersistenceService {
  
  final Ref ref;
  BadgePersistenceService(this.ref);

  static const String badgeAchievedConfig = 'badgeAchievedConfig';
  late SharedPreferences prefs;

  Future<bool> initLocalStorage() {

    Completer<bool> localStorageCompleter = Completer();

    ref.read(sharedPrefsLoaderProvider.future).then((sp) {
      prefs = sp;

      Future.delayed(2.seconds, () {
        localStorageCompleter.complete(true);
      });
    });

    return localStorageCompleter.future;
  }

  void storeBadgesAchievedConfig(String config) {
    String currentBadgesConfig = getBadgesAchievedConfig();
    List<String> badges = currentBadgesConfig.split(',');
    if (badges.contains(config)) {
      return;
    }

    badges.add(config);
    String updatedBadgesConfig = badges.join(',');
    prefs.setString(BadgePersistenceService.badgeAchievedConfig, updatedBadgesConfig);
  }

  String getBadgesAchievedConfig() {
    return prefs.getString(BadgePersistenceService.badgeAchievedConfig) ?? '';
  }
}