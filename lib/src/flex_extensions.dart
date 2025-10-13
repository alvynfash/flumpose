import 'package:flutter/widgets.dart';

/// Flex layout extensions for Flexible, Expanded, and Spacer
extension FlexExtensions on Widget {
  /// Wraps widget in Expanded
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Wraps widget in Flexible
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Wraps widget in Flexible with tight fit
  Widget flexibleTight({int flex = 1}) =>
      Flexible(flex: flex, fit: FlexFit.tight, child: this);
}

/// Spacer helpers for creating flexible space in Row/Column
class FlexSpace {
  const FlexSpace._();

  /// Creates a Spacer with flex = 1
  static const spacer = Spacer();

  /// Creates a Spacer with custom flex value
  static Widget flex(int flex) => Spacer(flex: flex);
}

/// FractionallySizedBox extensions for proportional sizing
extension FractionalSizeExtensions on Widget {
  /// Wraps widget in FractionallySizedBox
  Widget fractionalSize({
    double? widthFactor,
    double? heightFactor,
    Alignment alignment = Alignment.center,
  }) => FractionallySizedBox(
    widthFactor: widthFactor,
    heightFactor: heightFactor,
    alignment: alignment,
    child: this,
  );

  /// Makes widget take up a fraction of parent width
  Widget fractionalWidth(double factor) =>
      FractionallySizedBox(widthFactor: factor.clamp(0.0, 1.0), child: this);

  /// Makes widget take up a fraction of parent height
  Widget fractionalHeight(double factor) =>
      FractionallySizedBox(heightFactor: factor.clamp(0.0, 1.0), child: this);

  /// Makes widget take up half the parent width
  Widget halfWidth() => FractionallySizedBox(widthFactor: 0.5, child: this);

  /// Makes widget take up half the parent height
  Widget halfHeight() => FractionallySizedBox(heightFactor: 0.5, child: this);

  /// Makes widget fill parent (100% width and height)
  Widget fillParent() =>
      const FractionallySizedBox(widthFactor: 1.0, heightFactor: 1.0);
}

/// AspectRatio extensions for maintaining aspect ratios
extension AspectRatioExtensions on Widget {
  /// Wraps widget in AspectRatio
  Widget aspectRatio(double ratio) =>
      AspectRatio(aspectRatio: ratio, child: this);

  /// Square aspect ratio (1:1)
  Widget square() => AspectRatio(aspectRatio: 1.0, child: this);

  /// 16:9 aspect ratio (common for videos)
  Widget aspect16x9() => AspectRatio(aspectRatio: 16 / 9, child: this);

  /// 4:3 aspect ratio
  Widget aspect4x3() => AspectRatio(aspectRatio: 4 / 3, child: this);

  /// 21:9 aspect ratio (ultra-wide)
  Widget aspect21x9() => AspectRatio(aspectRatio: 21 / 9, child: this);
}

/// FittedBox extensions for scaling and fitting
extension FittedBoxExtensions on Widget {
  /// Wraps widget in FittedBox
  Widget fitted({
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
  }) => FittedBox(fit: fit, alignment: alignment, child: this);

  /// Scales widget to contain within parent
  Widget fitContain() => FittedBox(fit: BoxFit.contain, child: this);

  /// Scales widget to cover parent
  Widget fitCover() => FittedBox(fit: BoxFit.cover, child: this);

  /// Scales widget to fill parent (may distort)
  Widget fitFill() => FittedBox(fit: BoxFit.fill, child: this);

  /// Scales widget down if needed, but never up
  Widget fitScaleDown() => FittedBox(fit: BoxFit.scaleDown, child: this);
}
