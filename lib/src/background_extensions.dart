import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'animation_extensions.dart';

extension BackgroundColorExtension on Widget {
  /// Set [animate] to true to animate background color changes
  Widget backgroundColor(Color color, {bool animate = false}) {
    if (!animate) return Container(color: color, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedContainer(
        color: color,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }
}

extension BackgroundImageExtension on Widget {
  Widget backgroundImage(
    ImageProvider image, {
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: image, fit: fit, alignment: alignment),
      ),
      child: this,
    );
  }
}

extension BackgroundGradientExtension on Widget {
  /// Set [animate] to true to animate gradient changes
  Widget backgroundGradient(Gradient gradient, {bool animate = false}) {
    if (!animate) {
      return Container(
        decoration: BoxDecoration(gradient: gradient),
        child: this,
      );
    }

    return AnimatedWrapper(
      builder: (config) => AnimatedContainer(
        decoration: BoxDecoration(gradient: gradient),
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  Widget backgroundLinearGradient({
    required List<Color> colors,
    Alignment begin = Alignment.topCenter,
    Alignment end = Alignment.bottomCenter,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
  }) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: begin,
        end: end,
        stops: stops,
        tileMode: tileMode,
      ),
    ),
    child: this,
  );

  Widget backgroundRadialGradient({
    required List<Color> colors,
    Alignment center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
  }) => Container(
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: colors,
        center: center,
        radius: radius,
        stops: stops,
        tileMode: tileMode,
      ),
    ),
    child: this,
  );
}

extension DecoratedExtension on Widget {
  Widget decorated(BoxDecoration decoration) =>
      Container(decoration: decoration, child: this);
}
