import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';

class GameLoopService {

  Timer loopTimer = Timer(0.seconds, () {});
  final Ref ref;

  GameLoopService(this.ref);
  
  startGameLoop() {
    loopTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Utils.checkForCollision(Utils.vin1, Utils.cardboard, () {
        increaseTrashCount(cardboardCount);
      }, repeat: false);

      Utils.checkForCollision(Utils.vin1, Utils.plasticbag, () {
        increaseTrashCount(plasticBagCount);
        increaseLaserEnergyLevel(plasticBagCount);
      });

      Utils.checkForCollision(Utils.vin1, Utils.waterBottle, () {
        increaseTrashCount(waterBottleCount);
        increaseLaserEnergyLevel(waterBottleCount);
      });

      Utils.checkForCollision(Utils.vin1, Utils.sodaCan, () {
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
    // TODO: decrease lives
  }
  
  stopGameLoop() {
    loopTimer.cancel();
  }
}