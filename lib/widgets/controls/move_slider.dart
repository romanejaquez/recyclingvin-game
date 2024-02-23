import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MoveSlider extends ConsumerStatefulWidget {
  const MoveSlider({super.key});

  @override
  ConsumerState<MoveSlider> createState() => _MoveSliderState();
}

class _MoveSliderState extends ConsumerState<MoveSlider> {

  double xValue = 0;
  double calcXValue = 0;
  double maxXValue = 0;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sliderDim = getValueForScreenType(
      context: context, 
      mobile: const Size(100, 60),
      tablet: const Size(260, 180),
    );

    maxXValue = sliderDim.width / 2;

    if (!isInitialized) {
      xValue = (maxXValue / 2); 
      isInitialized = true;
      setState(() {});
    }

    var moveLeftOffset = getValueForScreenType(
      context: context, 
      mobile: 20,
      tablet: 260,
    );

    double sliderTrackWidth = getValueForScreenType(
      context: context, 
      mobile: 120,
      tablet: 260,
    );

    double sliderThumbWidth = getValueForScreenType(
      context: context, 
      mobile: 50,
      tablet: 100,
    );

    return Container(
      margin: RecyclingVinStyles.largeMargin.copyWith(
        bottom: 0,
      ),
      child: SizedBox(
        width: sliderDim.width,
        height: sliderDim.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            
            SvgPicture.asset('./assets/imgs/greenbtn_slider.svg',
              width: sliderTrackWidth, 
              height: sliderTrackWidth,
              fit: BoxFit.contain,
            ),
        
            Positioned(
              left: xValue,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    if (details.delta.dx > 0)
                    {
                      if (xValue <= maxXValue) {
                        xValue += details.delta.distance;
                      }
                    }
                    else if (details.delta.dx < 0){
                      if  (xValue >= 0) {
                        xValue -= details.delta.distance;
                      }
                    }

                    calcXValue = xValue * 4;
                    ref.read(vinPositionProvider.notifier).state = calcXValue + moveLeftOffset;
                  });
                },
                child: SvgPicture.asset('./assets/imgs/greenbottlecap.svg',
                  width: sliderThumbWidth, 
                  height: sliderThumbWidth,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}