import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'animation_extensions.dart';

extension TransformExtensions on Widget {
  /// Set [animate] to true to animate rotation changes
  Widget rotate(
    double angle, {
    Alignment alignment = Alignment.center,
    bool animate = false,
  }) {
    if (!animate) {
      return Transform.rotate(angle: angle, alignment: alignment, child: this);
    }

    return AnimatedWrapper(
      builder: (config) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: angle),
        duration: config.duration,
        curve: config.curve,
        builder: (context, value, child) =>
            Transform.rotate(angle: value, alignment: alignment, child: child),
        child: this,
      ),
    );
  }

  /// Set [animate] to true to animate scale changes
  Widget scaleWidget(
    double scale, {
    Alignment alignment = Alignment.center,
    bool animate = false,
  }) {
    if (!animate) {
      return Transform.scale(scale: scale, alignment: alignment, child: this);
    }

    return AnimatedWrapper(
      builder: (config) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 1, end: scale),
        duration: config.duration,
        curve: config.curve,
        builder: (context, value, child) =>
            Transform.scale(scale: value, alignment: alignment, child: child),
        child: this,
      ),
    );
  }

  /// Set [animate] to true to animate translation changes
  Widget translate({double x = 0, double y = 0, bool animate = false}) {
    if (!animate) {
      return Transform.translate(offset: Offset(x, y), child: this);
    }

    return AnimatedWrapper(
      builder: (config) => TweenAnimationBuilder<Offset>(
        tween: Tween(begin: Offset.zero, end: Offset(x, y)),
        duration: config.duration,
        curve: config.curve,
        builder: (context, value, child) =>
            Transform.translate(offset: value, child: child),
        child: this,
      ),
    );
  }

  Widget transform(Matrix4 matrix, {Alignment? alignment}) =>
      Transform(transform: matrix, alignment: alignment, child: this);
}
