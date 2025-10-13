import 'package:flutter/widgets.dart';

/// Positioned extensions for Stack children
extension PositionedExtensions on Widget {
  /// Wraps widget in Positioned with all sides
  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) => Positioned(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    width: width,
    height: height,
    child: this,
  );

  /// Positions widget at top-left corner
  Widget positionedTopLeft({double top = 0, double left = 0}) =>
      Positioned(top: top, left: left, child: this);

  /// Positions widget at top-right corner
  Widget positionedTopRight({double top = 0, double right = 0}) =>
      Positioned(top: top, right: right, child: this);

  /// Positions widget at bottom-left corner
  Widget positionedBottomLeft({double bottom = 0, double left = 0}) =>
      Positioned(bottom: bottom, left: left, child: this);

  /// Positions widget at bottom-right corner
  Widget positionedBottomRight({double bottom = 0, double right = 0}) =>
      Positioned(bottom: bottom, right: right, child: this);

  /// Positions widget to fill parent
  Widget positionedFill() => Positioned.fill(child: this);

  /// Positions widget with directional properties
  Widget positionedDirectional({
    required TextDirection textDirection,
    double? start,
    double? top,
    double? end,
    double? bottom,
    double? width,
    double? height,
  }) => Positioned.directional(
    textDirection: textDirection,
    start: start,
    top: top,
    end: end,
    bottom: bottom,
    width: width,
    height: height,
    child: this,
  );

  /// Centers widget in Stack
  Widget positionedCenter() => Positioned.fill(child: Center(child: this));
}

/// Stack builder extension for creating stacks easily
extension StackExtensions on Widget {
  /// Wraps widget in a Stack with additional children
  Widget stack({
    required List<Widget> children,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) => Stack(
    alignment: alignment,
    textDirection: textDirection,
    fit: fit,
    clipBehavior: clipBehavior,
    children: [this, ...children],
  );

  /// Creates a Stack with this widget as background and overlay on top
  Widget withOverlay(Widget overlay) => Stack(children: [this, overlay]);

  /// Creates a Stack with this widget on top of a background
  Widget onTopOf(Widget background) => Stack(children: [background, this]);
}

/// IndexedStack extension for tab-like behavior
extension IndexedStackExtensions on List<Widget> {
  /// Creates an IndexedStack from a list of widgets
  Widget indexedStack({
    required int index,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit sizing = StackFit.loose,
  }) => IndexedStack(
    index: index,
    alignment: alignment,
    textDirection: textDirection,
    sizing: sizing,
    children: this,
  );
}
