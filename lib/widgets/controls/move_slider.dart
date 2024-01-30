import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';
import 'package:recyclingvin_web/providers/game_providers.dart';

class MoveSlider extends ConsumerStatefulWidget {
  const MoveSlider({super.key});

  @override
  ConsumerState<MoveSlider> createState() => _MoveSliderState();
}

class _MoveSliderState extends ConsumerState<MoveSlider> {

  double xValue = 0;
  double calcXValue = 0;
  double maxXValue = 140;
  double greenBtnWidth = 100;

  @override
  void initState() {
    super.initState();

    xValue = (maxXValue / 2); // - (greenBtnWidth / 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: RecyclingVinStyles.largeMargin.copyWith(
        bottom: 0,
      ),
      child: SizedBox(
        width: 250,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            
            SvgPicture.asset('./assets/imgs/greenbtn_slider.svg',
              width: 200, height: 100,
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
                    ref.read(vinPositionProvider.notifier).state = calcXValue + 260;
                  });
                },
                child: SvgPicture.asset('./assets/imgs/greenbottlecap.svg',
                  width: greenBtnWidth, 
                  height: greenBtnWidth,
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