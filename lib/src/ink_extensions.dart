import 'package:flutter/material.dart';

/// Ink and splash effect extensions
extension InkExtensions on Widget {
  /// Wrap in InkWell with tap handler
  /// Performance: Single InkWell wrapper with Material ripple
  Widget inkWell({
    VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onLongPress,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    Color? focusColor,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool enableFeedback = true,
  }) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      splashColor: splashColor,
      highlightColor: highlightColor,
      hoverColor: hoverColor,
      focusColor: focusColor,
      borderRadius: borderRadius,
      customBorder: customBorder,
      enableFeedback: enableFeedback,
      child: this,
    );
  }

  /// Wrap in Ink with decoration
  /// Performance: Single Ink widget for proper Material ripple rendering
  Widget ink({
    Color? color,
    Decoration? decoration,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
  }) {
    return Ink(
      color: color,
      decoration: decoration,
      width: width,
      height: height,
      padding: padding,
      child: this,
    );
  }

  /// Ink with color and tap handler
  /// Performance: Combines Ink + InkWell for optimal Material rendering
  Widget inkTap({
    required VoidCallback onTap,
    Color? color,
    Color? splashColor,
    BorderRadius? borderRadius,
  }) {
    return Ink(
      color: color,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: borderRadius,
        child: this,
      ),
    );
  }

  /// Ink with decoration and tap handler
  /// Performance: Optimized for decorated Material buttons
  Widget inkDecoration({
    required VoidCallback onTap,
    Decoration? decoration,
    Color? splashColor,
    BorderRadius? borderRadius,
  }) {
    return Ink(
      decoration: decoration,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: borderRadius,
        child: this,
      ),
    );
  }

  /// Material ink response (like InkWell but without tap)
  /// Performance: Lightweight Material response without gesture detection
  Widget inkResponse({
    VoidCallback? onTap,
    Color? splashColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
  }) {
    return InkResponse(
      onTap: onTap,
      splashColor: splashColor,
      highlightColor: highlightColor,
      borderRadius: borderRadius,
      customBorder: customBorder,
      child: this,
    );
  }
}
