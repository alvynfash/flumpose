import 'package:flutter/widgets.dart';

/// Visibility and opacity extensions for showing/hiding widgets
extension VisibilityExtensions on Widget {
  /// Wraps widget in Visibility with visible flag
  Widget visible(bool visible) => Visibility(visible: visible, child: this);

  /// Hides the widget (Visibility with visible: false)
  Widget hide() => Visibility(visible: false, child: this);

  /// Shows the widget (returns widget as-is)
  Widget show() => this;

  /// Conditionally shows or hides the widget
  Widget showIf(bool condition) => Visibility(visible: condition, child: this);

  /// Wraps widget in Visibility with maintainSize, maintainAnimation, maintainState
  Widget invisibleButKeepSpace() => Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    child: this,
  );

  /// Wraps widget in Opacity
  Widget opacity(double opacity) =>
      Opacity(opacity: opacity.clamp(0.0, 1.0), child: this);

  /// Makes widget semi-transparent (50% opacity)
  Widget semiTransparent() => Opacity(opacity: 0.5, child: this);

  /// Makes widget mostly transparent (25% opacity)
  Widget mostlyTransparent() => Opacity(opacity: 0.25, child: this);

  /// Ignores pointer events (makes widget non-interactive)
  Widget ignorePointer({bool ignoring = true}) =>
      IgnorePointer(ignoring: ignoring, child: this);

  /// Absorbs pointer events (prevents hits from reaching widgets behind)
  Widget absorbPointer({bool absorbing = true}) =>
      AbsorbPointer(absorbing: absorbing, child: this);
}
