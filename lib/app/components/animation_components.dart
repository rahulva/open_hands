import 'package:flutter/material.dart';

AnimatedBuilder animationWrapper(
    Widget contentWidget, AnimationController? animationController, Animation<double>? animation) {
  return AnimatedBuilder(
    animation: animationController!,
    builder: (BuildContext context, Widget? child) {
      return FadeTransition(
        opacity: animation!,
        child: Transform(
          transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
          child: contentWidget,
        ),
      );
    },
  );
}

class AnimationStateHolder {
  AnimationController? animationController;
  Animation<double>? animation;

  initAnimationController(TickerProvider vsync) {
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: vsync);
  }

  void initAnimation(int length, int index) {
    // var length2 = requestList.length;
    final int count = length > 10 ? 10 : length;
    var interval = Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn);
    var curvedAnimation = CurvedAnimation(parent: animationController!, curve: interval);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);
    animationController?.forward();
  }

  // AnimationController? getAnimationController() {
  //   return animationController;
  // }

  void disposeAnimation() {
    animationController?.dispose();
  }
}
