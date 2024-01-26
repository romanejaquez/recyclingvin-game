import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/onboarding_badge.dart';

class OnboardingPanel extends ConsumerWidget {
  const OnboardingPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
                    OnboardingBadge(option: currentStepContent.badge),
                    RecyclingVinStyles.xlargeGap,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentStepContent.title, style: RecyclingVinStyles.heading1.copyWith(
                          color: currentStepContent.titleColor,
                        )),
                        Text(currentStepContent.content,
                          style: RecyclingVinStyles.heading5
                        ),
                      ],
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
                      Navigator.of(context).pop();
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
        ),

      ),
    );
  }
}