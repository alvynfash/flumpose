import 'package:flutter/material.dart';

/// List extensions for quick Column/Row builders with spacing
extension ListWidgetExtensions on List<Widget> {
  /// Convert list to Column with optional spacing between children
  /// Performance: Only creates SizedBox widgets when spacing > 0
  Column toColumn({
    double spacing = 0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: spacing > 0 ? _withVerticalSpacing(spacing) : this,
    );
  }

  /// Convert list to Row with optional spacing between children
  /// Performance: Only creates SizedBox widgets when spacing > 0
  Row toRow({
    double spacing = 0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: spacing > 0 ? _withHorizontalSpacing(spacing) : this,
    );
  }

  /// Internal helper to add vertical spacing between widgets
  List<Widget> _withVerticalSpacing(double spacing) {
    if (isEmpty) return this;
    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(SizedBox(height: spacing));
      }
    }
    return result;
  }

  /// Internal helper to add horizontal spacing between widgets
  List<Widget> _withHorizontalSpacing(double spacing) {
    if (isEmpty) return this;
    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(SizedBox(width: spacing));
      }
    }
    return result;
  }
}
