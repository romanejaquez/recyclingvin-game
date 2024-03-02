import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/dialogs/playerlost.dart';
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
        PlayerLostDialog(
          onSelection: (PlayerLostDialogSelection selection) {
            if (selection == PlayerLostDialogSelection.yes) {
              // restart game
            }
            else {
              // back to the beginning
              Navigator.of(context).pop();
            }
          }
        )
      ));
    }

    return const SizedBox.shrink();
  }
}