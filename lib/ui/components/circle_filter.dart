import 'dart:ui';

import 'package:flutter/material.dart';

class PositionedCircleFilter extends StatelessWidget {
  const PositionedCircleFilter({
    super.key,
    this.positionedTop,
    this.positionedBottom,
    this.positionedRight,
    this.positionedLeft,
    this.positionedWidth,
    this.positionedHeight,
    this.sigmaX = 100,
    this.sigmaY = 100,
    this.sizeHeight,
    this.sizeWidth,
  });

  final double? positionedTop;
  final double? positionedBottom;
  final double? positionedRight;
  final double? positionedLeft;
  final double? positionedWidth;
  final double? positionedHeight;
  final double sigmaX;
  final double sigmaY;
  final double? sizeHeight;
  final double? sizeWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: positionedTop,
      bottom: positionedBottom,
      right: positionedRight,
      left: positionedLeft,
      height: positionedHeight,
      width: positionedWidth,
      child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
            tileMode: TileMode.decal, // Agrega tileMode.decal aquí
          ),
          child: Container(
            height: sizeHeight,
            width: sizeWidth,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 229, 255, 0),
            ),
          )),
    );
  }
}
