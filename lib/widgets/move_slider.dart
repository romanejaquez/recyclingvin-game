import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recyclingvin_web/helpers/styles.dart';

class MoveSlider extends StatefulWidget {
  const MoveSlider({super.key});

  @override
  State<MoveSlider> createState() => _MoveSliderState();
}

class _MoveSliderState extends State<MoveSlider> {

  double xValue = 0;
  double maxXValue = 140;

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
                  });
                },
                child: SvgPicture.asset('./assets/imgs/greenbottlecap.svg',
                  width: 100, height: 100,
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