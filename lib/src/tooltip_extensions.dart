import 'package:flutter/material.dart';

/// Tooltip extensions for adding tooltips to widgets
extension TooltipExtensions on Widget {
  /// Wrap widget in a Tooltip
  /// Performance: Zero overhead wrapper, uses Flutter's built-in Tooltip
  Widget tooltip(
    String message, {
    Decoration? decoration,
    BoxConstraints? constraints,
    bool? preferBelow,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? verticalOffset,
    bool? enableFeedback,
    TooltipTriggerMode? triggerMode,
    Duration? waitDuration,
    Duration? showDuration,
    TextStyle? textStyle,
    TextAlign? textAlign,
  }) {
    return Tooltip(
      message: message,
      decoration: decoration,
      constraints: constraints,
      preferBelow: preferBelow,
      padding: padding,
      margin: margin,
      verticalOffset: verticalOffset,
      enableFeedback: enableFeedback,
      triggerMode: triggerMode,
      waitDuration: waitDuration,
      showDuration: showDuration,
      textStyle: textStyle,
      textAlign: textAlign,
      child: this,
    );
  }
}
