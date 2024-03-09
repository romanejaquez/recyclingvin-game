import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rive/rive.dart';

class Utils {

  static RiveFile? introFile;
  static RiveFile? mainFile;
  static RiveFile? gameAssetsFile;
  static RiveFile? duuprGameStudioFile;

  static final GlobalKey waterBottle = GlobalKey();
  static final GlobalKey sodaCan = GlobalKey();
  static final GlobalKey trashBag = GlobalKey();
  static final GlobalKey plasticbag= GlobalKey();
  static final GlobalKey cardboard = GlobalKey();

  static final GlobalKey tree1 = GlobalKey();
  static final GlobalKey tree2 = GlobalKey();
  static final GlobalKey tree3 = GlobalKey();
  
  static final GlobalKey enemy1 = GlobalKey();
  static final GlobalKey enemy2 = GlobalKey();
  static final GlobalKey enemy3 = GlobalKey();

  static final GlobalKey vin1 = GlobalKey();
  static final GlobalKey vin2 = GlobalKey();

  static Size? getDimensionFromAsset(BuildContext ctxt, GameAssetOptions asset) {
    return 
        getValueForScreenType(context: ctxt, 
          mobile: switch(asset) {
            GameAssetOptions.tree => const Size(50, 50),
            GameAssetOptions.vinheart => const Size(40, 40),
            GameAssetOptions.waterbottle ||
              GameAssetOptions.cardboardbox || 
                GameAssetOptions.plasticbag ||
                  GameAssetOptions.sodacan => const Size(125, 125),

            GameAssetOptions.vin => const Size(150, 150),
            GameAssetOptions.frackingstein => const Size(140, 140),
          },
        tablet: switch(asset) {
            GameAssetOptions.tree => const Size(300, 200),
            GameAssetOptions.vinheart => const Size(50, 50),
            GameAssetOptions.waterbottle ||
              GameAssetOptions.cardboardbox || 
                GameAssetOptions.plasticbag ||
                  GameAssetOptions.sodacan => const Size(250, 150),

            GameAssetOptions.vin => const Size(320, 320),
            GameAssetOptions.frackingstein => const Size(280, 280),
          },
      );
  }

  static Map<GlobalKey, AnimationController> controllerMap = {};

  static void checkForCollision(GlobalKey firstItem, GlobalKey secondItem, Function onCollideCallback, { bool repeat = true }) {

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

      if (repeat) {
        Utils.controllerMap[secondItem]!.forward();
      }
      onCollideCallback();
      return;
    }
  }

  static bool isMobile() {
    return false;
  }

  static void showUIModal(
    BuildContext context, 
    Widget child,
    { bool dismissible = false, Function? onDismissed, }) {
   
    if (isMobile()) {
      showModalBottomSheet(
        isDismissible: dismissible,
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctxt) {
          return child;
        }
      ).whenComplete(() {
        //onDismissed!();
      });
    }
    else {
      showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: Colors.black.withOpacity(0.75),
        builder: (ctxt) {
          return PopScope(
            canPop: false,
            child: FractionallySizedBox(
              widthFactor: 0.7,
              heightFactor: 0.8,
              child: child
            ),
          );
        }
      ).whenComplete(() {
       // onDismissed!();
      });
    }
    
  }

  static Color colorFromBadge(RecyclingBadgeOptions option) {
    switch(option) {
      case RecyclingBadgeOptions.bagBuster:
        return RecyclingVinColors.bagBusterColor;
      case RecyclingBadgeOptions.plasticPioneer:
        return RecyclingVinColors.plasticPioneerColor;
      case RecyclingBadgeOptions.canCrusher:
        return RecyclingVinColors.canCrusherColor;
      default:
        return Colors.transparent;
    }
  }

  static String labelFromBadge(RecyclingBadgeOptions option) {
    switch(option) {
      case RecyclingBadgeOptions.bagBuster:
        return 'Bag Buster';
      case RecyclingBadgeOptions.plasticPioneer:
        return 'Plastic Pioneer';
      case RecyclingBadgeOptions.canCrusher:
        return 'Can Crusher';
      default:
        return '';
    }
  }

  static Color getColorPerLaserLevel(double laserLevel) {

    if (laserLevel < 0.25) {
      return RecyclingVinColors.laserGunRed;
    }

    if (laserLevel < 0.65) {
      return Colors.orange;
    }

    return RecyclingVinColors.laserGunGreen;
  }
}