import 'dart:ui';
import 'package:flutter/material.dart';

/// Blur effect extensions
extension BlurExtensions on Widget {
  /// Apply blur effect to widget
  /// Performance: Uses ImageFilter.blur with single BackdropFilter
  Widget blur({
    double sigmaX = 5.0,
    double sigmaY = 5.0,
    TileMode tileMode = TileMode.clamp,
  }) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
          tileMode: tileMode,
        ),
        child: this,
      ),
    );
  }

  /// Apply backdrop blur (blurs content behind)
  /// Performance: Single BackdropFilter, commonly used for frosted glass effect
  Widget backdropBlur({double sigma = 10.0, Color? overlayColor}) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          color: overlayColor ?? Colors.transparent,
          child: this,
        ),
      ),
    );
  }

  /// Frosted glass effect (blur + semi-transparent overlay)
  /// Performance: Optimized for common frosted glass pattern
  Widget frostedGlass({
    double sigma = 10.0,
    Color? color,
    double opacity = 0.3,
  }) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          color: (color ?? Colors.white).withValues(alpha: opacity),
          child: this,
        ),
      ),
    );
  }

  /// Apply blur with border radius
  /// Performance: ClipRRect + BackdropFilter
  Widget blurRounded({
    double sigma = 5.0,
    BorderRadius? borderRadius,
    double radius = 8.0,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: this,
      ),
    );
  }
}
