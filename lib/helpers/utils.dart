import 'dart:ui';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:rive/rive.dart';

class Utils {

  static RiveFile? mainFile;
  static RiveFile? gameAssetsFile;
  static RiveFile? duuprGameStudioFile;

  static Size getDimensionFromAsset(GameAssetOptions asset) {
    switch(asset) {
      case GameAssetOptions.tree:
        return const Size(300, 200);
      default: 
        return const Size(250, 150);
    }
  }
}