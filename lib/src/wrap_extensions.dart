import 'package:flutter/material.dart';

/// Wrap and Flow layout extensions
extension WrapExtensions on List<Widget> {
  /// Convert list to Wrap widget
  /// Performance: Single Wrap widget with configurable spacing
  Widget toWrap({
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    double spacing = 0.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 0.0,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
  }) {
    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      children: this,
    );
  }

  /// Convert list to Flow widget with custom delegate
  /// Performance: Efficient for custom layouts with many children
  Widget toFlow({
    required FlowDelegate delegate,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return Flow(delegate: delegate, clipBehavior: clipBehavior, children: this);
  }

  /// Convert list to horizontal Wrap with spacing
  /// Performance: Optimized shorthand for horizontal wrapping
  Widget toHorizontalWrap({
    double spacing = 8.0,
    double runSpacing = 8.0,
    WrapAlignment alignment = WrapAlignment.start,
  }) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      children: this,
    );
  }

  /// Convert list to vertical Wrap with spacing
  /// Performance: Optimized shorthand for vertical wrapping
  Widget toVerticalWrap({
    double spacing = 8.0,
    double runSpacing = 8.0,
    WrapAlignment alignment = WrapAlignment.start,
  }) {
    return Wrap(
      direction: Axis.vertical,
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      children: this,
    );
  }
}

/// Single widget Wrap extensions
extension SingleWidgetWrapExtensions on Widget {
  /// Wrap widget in Wrap (useful for single child with Wrap properties)
  /// Performance: Single Wrap widget wrapper
  Widget wrap({
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    double spacing = 0.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 0.0,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
  }) {
    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      children: [this],
    );
  }
}
