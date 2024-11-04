import 'package:flutter/material.dart';
import 'package:minimal_app/ui/components/circular_loading.dart';

class Overloading {
  Overloading._();
  static final Overloading instance = Overloading._();
  OverlayEntry overLayEntry({bool isAnimationTime = true}) => OverlayEntry(
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return Positioned(
            height: size.height,
            width: size.width,
            child: Material(
              color: Colors.white.withOpacity(0.4),
              child: CircularLoadingWidget(
                height: 200,
                isAnimationTime: isAnimationTime,
              ),
            ),
          );
        },
      );
}
