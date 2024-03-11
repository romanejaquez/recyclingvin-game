import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/pages/splashpage.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/logos/duuprgameslogo.dart';
import 'package:rive/rive.dart';

class MainSplashPage extends ConsumerStatefulWidget {

  static const String route = '/mainsplash';
  const MainSplashPage({super.key});

  @override
  ConsumerState<MainSplashPage> createState() => _MainSplashPageState();
}

class _MainSplashPageState extends ConsumerState<MainSplashPage> {

  bool isCoreLogoLoaded = false;
  Timer splashPageTimer = Timer(0.seconds, () {});

  @override
  void initState() {
    super.initState();
    preloadFile();
  }

  Future<void> preloadFile() async {
    Utils.duuprGameStudioFile = RiveFile.import(await rootBundle.load('./assets/anims/duuprgamestudio.riv'));
     
    setState(() {
      isCoreLogoLoaded = true;
    });

    Utils.mainFile = RiveFile.import(await rootBundle.load('./assets/anims/recyclingvin.riv'));
    Utils.gameAssetsFile = RiveFile.import(await rootBundle.load('./assets/anims/recyclingvin_game_assets.riv'));
    Utils.introFile = RiveFile.import(await rootBundle.load('./assets/anims/recyclingvinintro.riv'));

    final badgeStorage = ref.read(badgeStorageProvider);
    final storageInit = await badgeStorage.initLocalStorage();
    await ref.read(audioSoundProvider).initSounds();
    
    if (storageInit) {
      splashPageTimer = Timer(2.seconds, () {
        Navigator.of(context).pushNamed(SplashPage.route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: Center(
        child: isCoreLogoLoaded ? 
          const DuuprGamesLogo(defaultLogo: true) : 
        const SizedBox.shrink(),
      )
    );
  }
}