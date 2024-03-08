import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:recyclingvin_web/widgets/onboarding/onboarding_badge.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OnboardingPanel extends ConsumerStatefulWidget {

  final Function onboardingComplete;
  const OnboardingPanel({
    required this.onboardingComplete,
    super.key
  });
  
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

    final onboardingContentStack = getValueForScreenType(
      context: context, 

      // mobile
      mobile: Stack(
        children: [
          SvgPicture.asset('./assets/imgs/dialogbg.svg',
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding: RecyclingVinStyles.largePadding,
              child: Column(
                key: ValueKey(currentStep),
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: OnboardingBadge(option: currentStepContent.badge)
                    .animate()
                    .scaleXY(
                      begin: 0.5, end: 1,
                      curve: Curves.easeInOut,
                      duration: 0.25.seconds,
                    ),
                  ),
                  RecyclingVinStyles.smallGap,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(currentStepContent.title,
                        textAlign: TextAlign.center,
                        style: RecyclingVinStyles.heading4.copyWith(
                        color: currentStepContent.titleColor,
                      )),
                      Text(currentStepContent.content,
                        textAlign: TextAlign.center,
                        style: RecyclingVinStyles.heading6
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
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: RecyclingVinStyles.xlargeSize * 3),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: RecyclingVinStyles.mediumPadding,
                  backgroundColor: nextButtonColor,
                  foregroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RecyclingVinStyles.smallGap,
                    Text(nextLabel, style: RecyclingVinStyles.heading5),
                    RecyclingVinStyles.smallGap,
                    SvgPicture.asset('./assets/imgs/rightarrow.svg',
                      width: 60, height: 30
                    )
                  ],
                ),
                onPressed: () {
                  if (isLastStep) {
                    controller.reverse().whenComplete(() {
                      widget.onboardingComplete();
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
      ),

      // tablet
      tablet: Stack(
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
                      widget.onboardingComplete();
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
      )
    );
    
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        child: onboardingContentStack.animate(
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