import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:rive/rive.dart';

class Utils {

  static RiveFile? mainFile;
  static RiveFile? gameAssetsFile;
  static RiveFile? duuprGameStudioFile;

  static final GlobalKey waterBottle = GlobalKey();
  static final GlobalKey sodaCan = GlobalKey();
  static final GlobalKey trashBag = GlobalKey();
  static final GlobalKey cardboard = GlobalKey();
  static final GlobalKey laser = GlobalKey();

  static final GlobalKey tree1 = GlobalKey();
  static final GlobalKey tree2 = GlobalKey();
  static final GlobalKey tree3 = GlobalKey();
  

  static final GlobalKey enemy1 = GlobalKey();
  static final GlobalKey enemy2 = GlobalKey();
  static final GlobalKey enemy3 = GlobalKey();

  static final GlobalKey vin1 = GlobalKey();
  static final GlobalKey vin2 = GlobalKey();

  static Size getDimensionFromAsset(GameAssetOptions asset) {
    switch(asset) {
      case GameAssetOptions.tree:
        return const Size(300, 200);
      default: 
        return const Size(250, 150);
    }
  }

  static Map<GlobalKey, AnimationController> controllerMap = {};

  static void checkForCollision(GlobalKey firstItem, GlobalKey secondItem, Function onCollideCallback) {

    RenderBox? box1 = firstItem.currentContext!.findRenderObject() as RenderBox;
    RenderBox? box2 = secondItem.currentContext!.findRenderObject() as RenderBox;

    final size1 = box1.size;
    final size2 = box2.size;

    final position1 = box1.localToGlobal(Offset.zero);
    final position2 = box2.localToGlobal(Offset.zero);

    final collide = (position1.dx < position2.dx + size2.width &&
      position1.dx + size1.width > position2.dx &&
      position1.dy < position2.dy + size2.height &&
      position1.dy + size1.height > position2.dy);

    if (collide) {
      Utils.controllerMap[secondItem]!.reset();
      Utils.controllerMap[secondItem]!.forward();
      onCollideCallback();
      return;
    }
  }
}