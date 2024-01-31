import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/onboarding/onboarding_badge.dart';

class OnboardingPanel extends ConsumerStatefulWidget {
  const OnboardingPanel({super.key});
  
  @override
  OnboardingPanelState createState() => OnboardingPanelState();
}

class OnboardingPanelState extends ConsumerState<OnboardingPanel> {

  late AnimationController controller;

  @override
  Widget build(BuildContext context) {

    final onboardingSteps = ref.read(onboardingStepsProvider).onboardingSteps();
    final currentStep = ref.watch(onboardStepIndex);
    final currentStepContent = onboardingSteps[currentStep];
    final isLastStep = currentStep == onboardingSteps.length - 1;
    final nextLabel = isLastStep ? "Let's Go!" : "Next";
    final nextButtonColor = currentStepContent.titleColor;
    
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Stack(
          children: [
            SvgPicture.asset('./assets/imgs/dialogbg.svg'),
            Center(
              child: Padding(
                padding: RecyclingVinStyles.xLargePadding,
                child: Row(
                  key: ValueKey(currentStep),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OnboardingBadge(option: currentStepContent.badge)
                    .animate()
                    .scaleXY(
                      begin: 0.5, end: 1,
                      curve: Curves.easeInOut,
                      duration: 0.25.seconds,
                    ),
                    RecyclingVinStyles.xlargeGap,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentStepContent.title, style: RecyclingVinStyles.heading1.copyWith(
                            color: currentStepContent.titleColor,
                          )),
                          Text(currentStepContent.content,
                            style: RecyclingVinStyles.heading5
                          ),
                        ].animate(
                          interval: 100.ms,
                        ).slideX(
                          begin: 0.25, end: 0,
                          curve: Curves.easeInOut,
                          duration: 0.25.seconds,
                        ).fadeIn(
                          curve: Curves.easeInOut,
                          duration: 0.25.seconds,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: RecyclingVinStyles.x2largeSize),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: RecyclingVinStyles.largePadding,
                    backgroundColor: nextButtonColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RecyclingVinStyles.smallGap,
                      Text(nextLabel, style: RecyclingVinStyles.heading2),
                      RecyclingVinStyles.smallGap,
                      SvgPicture.asset('./assets/imgs/rightarrow.svg',
                        width: 60, height: 30
                      )
                    ],
                  ),
                  onPressed: () {
                    if (isLastStep) {
                      controller.reverse().whenComplete(() {
                        ref.read(gameStartedFlagProvider.notifier).state = true;
                        Navigator.of(context).pop();
                      });
                    }
                    else {
                      ref.read(onboardStepIndex.notifier).state += 1;
                    }
                  },
                ).animate(
                  onComplete: (controller) {
                    controller.repeat(reverse: true);
                  },
                )
                .scaleXY(
                  begin: 0.9, end: 1,
                  curve: Curves.easeInOut,
                  duration: 0.75.seconds,
                ),
              ),
            )
          ],
        ).animate(
          onInit: (ctrl) {
            controller = ctrl;
          },
        ).scaleXY(
          begin: 0.8, end: 1,
          curve: Curves.easeInOut,
          duration: 0.25.seconds,
        ).fadeIn(
          curve: Curves.easeInOut,
          duration: 0.25.seconds,
        )
      ),
    );
  }
}