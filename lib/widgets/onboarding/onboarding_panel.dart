import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
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

    if (currentStepContent.badge == OnboardingBadgeOptions.frackensteinbadge) {
      ref.read(audioSoundProvider).playSound(RecyclingVinSounds.frackingstein);
    }

    final dialogPadding = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.largePadding,
      tablet: RecyclingVinStyles.xLargePadding,
    );

    final dialogOrientation = getValueForScreenType(
      context: context, 
      mobile: Axis.vertical,
      tablet: Axis.horizontal
    );

    final mainAlignment = getValueForScreenType(
      context: context, 
      mobile: MainAxisAlignment.start,
      tablet: MainAxisAlignment.center,
    );

    double dialogBadgeHeight = getValueForScreenType(
      context: context, 
      mobile: 200,
      tablet: 400,
    );

    final dialogMiddleGap = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.smallGap,
      tablet: RecyclingVinStyles.xlargeGap,
    );

    final mainHeader = getValueForScreenType(
      context: context,
      mobile: RecyclingVinStyles.heading4,
      tablet: RecyclingVinStyles.heading1,  
    );

    final mainContent = getValueForScreenType(
      context: context,
      mobile: RecyclingVinStyles.heading6,
      tablet: RecyclingVinStyles.heading5,  
    );

    final dialogBgImg = getValueForScreenType(
      context: context, 
      mobile: SvgPicture.asset('./assets/imgs/dialogbg.svg',
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        fit: BoxFit.fill,
      ),
      tablet: SvgPicture.asset('./assets/imgs/dialogbg.svg'),
    );

    final dialogBtnAlignment = getValueForScreenType(
      context: context,
      mobile: Alignment.bottomCenter,
      tablet: Alignment.bottomRight,
    );

    final dialogBtnMargin = getValueForScreenType(
      context: context, 
      mobile: const EdgeInsets.only(bottom: RecyclingVinStyles.xlargeSize * 1.5),
      tablet: const EdgeInsets.only(bottom: RecyclingVinStyles.x2largeSize),
    );

    final dialogBtnPadding = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.mediumPadding,
      tablet: RecyclingVinStyles.largePadding,
    );

    final dialogBtnLabel = getValueForScreenType(
      context: context, 
      mobile: RecyclingVinStyles.heading5,
      tablet: RecyclingVinStyles.heading2
    );
    
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Stack(
        children: [
          dialogBgImg,
          Center(
            child: Padding(
              padding: dialogPadding,
              child: Flex(
                direction: dialogOrientation,
                key: ValueKey(currentStep),
                mainAxisAlignment: mainAlignment,
                children: [
                  SizedBox(
                    height: dialogBadgeHeight,
                    child: OnboardingBadge(option: currentStepContent.badge)
                    .animate()
                    .scaleXY(
                      begin: 0.5, end: 1,
                      curve: Curves.easeInOut,
                      duration: 0.25.seconds,
                    ),
                  ),
                  dialogMiddleGap,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: mainAlignment,
                      children: [
                        Text(currentStepContent.title,
                          textAlign: TextAlign.center,
                          style: mainHeader.copyWith(
                          color: currentStepContent.titleColor,
                        )),
                        Text(currentStepContent.content,
                          textAlign: TextAlign.center,
                          style: mainContent
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
            alignment: dialogBtnAlignment,
            child: Container(
              margin: dialogBtnMargin,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: dialogBtnPadding,
                  backgroundColor: nextButtonColor,
                  foregroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RecyclingVinStyles.smallGap,
                    Text(nextLabel, style: dialogBtnLabel),
                    RecyclingVinStyles.smallGap,
                    SvgPicture.asset('./assets/imgs/rightarrow.svg',
                      width: 60, height: 30
                    )
                  ],
                ),
                onPressed: () {
                  ref.read(audioSoundProvider).playSound(RecyclingVinSounds.click);
                  
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