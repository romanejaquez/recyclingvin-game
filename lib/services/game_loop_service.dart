import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/constants.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';

class GameLoopService {

  Timer loopTimer = Timer(0.seconds, () {});
  final Ref ref;
  bool gameStopped = false;

  GameLoopService(this.ref);
  
  startGameLoop() {
    ref.read(gameStartedFlagProvider.notifier).state = true;

    loopTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (gameStopped) {
        timer.cancel();
        return;
      }

      Utils.checkForCollision(Utils.vin1, Utils.cardboard, () {
        ref.read(audioSoundProvider).playSound(RecyclingVinSounds.cardboardRide);
        increaseTrashCount(cardboardCount);
      }, repeat: false);

      Utils.checkForCollision(Utils.vin1, Utils.plasticbag, () {
        ref.read(audioSoundProvider).playSound(RecyclingVinSounds.trash);
        increaseTrashCount(plasticBagCount);
        increaseLaserEnergyLevel(plasticBagCount);
      });

      Utils.checkForCollision(Utils.vin1, Utils.waterBottle, () {
        ref.read(audioSoundProvider).playSound(RecyclingVinSounds.trash);
        increaseTrashCount(waterBottleCount);
        increaseLaserEnergyLevel(waterBottleCount);
      });

      Utils.checkForCollision(Utils.vin1, Utils.sodaCan, () {
        ref.read(audioSoundProvider).playSound(RecyclingVinSounds.trash);
        increaseTrashCount(sodaCanCount);
        increaseLaserEnergyLevel(sodaCanCount);
      });

      Utils.checkForCollision(Utils.vin1, Utils.enemy1, () {
        decreaseLives();
      });

      Utils.checkForCollision(Utils.vin1, Utils.enemy2, () {
        decreaseLives();
      });
    });
  }

  increaseTrashCount(StateProvider prov) {
    ref.read(prov.notifier).state += 1;
  }

  increaseLaserEnergyLevel(StateProvider prov) {

    var laserLevel = ref.read(laserEnergyLevelProvider.notifier).state;

    if (laserLevel >= 1.0) {
      return;
    }

    var laserLevelIncrease = 0.0;

    var trashCount = ref.read(prov.notifier).state;
    if (trashCount % 5 == 0) {
      laserLevelIncrease += 0.05;
    }

    ref.read(laserEnergyLevelProvider.notifier).state = ref.read(laserEnergyLevelProvider.notifier).state + laserLevelIncrease;
  }

  decreaseLives() {
    ref.read(livesCountProvider.notifier).state -= 1;

    if (ref.read(livesCountProvider.notifier).state == 0) {
      stopGameLoop();
    }
  }
  
  stopGameLoop() {
    gameStopped = true;
    loopTimer.cancel();
    ref.read(gameStartedFlagProvider.notifier).state = false;
  }

  resetGame() {
    gameStopped = false;
    ref.read(livesCountProvider.notifier).state = Constants.defaultLives;
    ref.read(cardboardCount.notifier).state = 0;
    ref.read(plasticBagCount.notifier).state = 0;
    ref.read(sodaCanCount.notifier).state = 0;
    ref.read(waterBottleCount.notifier).state = 0;
    ref.read(laserEnergyLevelProvider.notifier).state = 1;
    ref.read(onboardStepIndex.notifier).state = 0;
    ref.read(triggerLaserProvider.notifier).state = VinShootingOptions.none;
    ref.read(vinPositionProvider.notifier).state = null;
    ref.read(gameWonProvider.notifier).state = false;
  }

  void setGameAsWon() {
    ref.read(gameWonProvider.notifier).state = true;
    stopGameLoop();
  }

  void exitGame() {
    gameStopped = true;
    stopGameLoop();
    resetGame();
  }

  void restartGame() {
    resetGame();
    startGameLoop();
  }
}