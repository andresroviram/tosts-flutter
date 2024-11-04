import 'dart:async';

import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatefulWidget {
  const CircularLoadingWidget({
    required this.height,
    super.key,
    this.isAnimationTime = true,
  });
  final double height;
  final bool isAnimationTime;

  @override
  CircularLoadingWidgetState createState() => CircularLoadingWidgetState();
}

class CircularLoadingWidgetState extends State<CircularLoadingWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween<double>(begin: widget.height, end: 0).animate(curve)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: widget.isAnimationTime
            ? animation.value / 100 > 1.0
                ? 1.0
                : animation.value / 100
            : 1.0,
        child: SizedBox(
          height: widget.isAnimationTime ? animation.value : null,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ),
      );
}
