import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/pages/gamepage.dart';
import 'package:recyclingvin_web/pages/mainsplash.dart';
import 'package:recyclingvin_web/pages/splashpage.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/dialogs/playerlost.dart';
import 'package:recyclingvin_web/widgets/dialogs/playerwin.dart';
import 'package:recyclingvin_web/widgets/onboarding/onboarding_panel.dart';

class GamePanels extends ConsumerStatefulWidget {
  const GamePanels({super.key});

  @override
  GamePanelsState createState() => GamePanelsState();
}

class GamePanelsState extends ConsumerState<GamePanels> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() => Utils.showUIModal(context,
      OnboardingPanel(
        onboardingComplete: () {
          ref.read(gameLoopProvider).startGameLoop();
          Navigator.of(context).pop();
        },
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    
    final lives = ref.watch(livesCountProvider);

    if (lives == 0) {
      Future.microtask(() => Utils.showUIModal(context,
        PlayerWinDialog(
          onSelection: (PlayerDialogSelection selection) {
            if (selection == PlayerDialogSelection.yes) {
              // restart game
              Navigator.of(context).pop();
              ref.read(gameLoopProvider).resetGame();
              ref.read(gameLoopProvider).startGameLoop();
            }
            else {
              ref.read(gameLoopProvider).resetGame();
              // pop twice to get to the menu
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          }
        )
      ));
    }

    return const SizedBox.shrink();
  }
}