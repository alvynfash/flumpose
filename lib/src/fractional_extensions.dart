import 'package:flutter/material.dart';

/// Fractional transformation extensions
extension FractionalExtensions on Widget {
  /// Translate by fraction of widget size
  /// Performance: Single FractionalTranslation widget
  Widget fractionalTranslate({
    double x = 0.0,
    double y = 0.0,
    bool transformHitTests = true,
  }) {
    return FractionalTranslation(
      translation: Offset(x, y),
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// Translate horizontally by fraction
  /// Performance: Optimized for horizontal-only translation
  Widget fractionalTranslateX(double x, {bool transformHitTests = true}) {
    return FractionalTranslation(
      translation: Offset(x, 0),
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// Translate vertically by fraction
  /// Performance: Optimized for vertical-only translation
  Widget fractionalTranslateY(double y, {bool transformHitTests = true}) {
    return FractionalTranslation(
      translation: Offset(0, y),
      transformHitTests: transformHitTests,
      child: this,
    );
  }

  /// Slide in from left (0.0 = fully visible, -1.0 = off screen left)
  /// Performance: Common animation pattern, single widget
  Widget slideFromLeft(double progress) {
    return FractionalTranslation(
      translation: Offset(-1 + progress, 0),
      child: this,
    );
  }

  /// Slide in from right (0.0 = fully visible, 1.0 = off screen right)
  /// Performance: Common animation pattern, single widget
  Widget slideFromRight(double progress) {
    return FractionalTranslation(
      translation: Offset(1 - progress, 0),
      child: this,
    );
  }

  /// Slide in from top (0.0 = fully visible, -1.0 = off screen top)
  /// Performance: Common animation pattern, single widget
  Widget slideFromTop(double progress) {
    return FractionalTranslation(
      translation: Offset(0, -1 + progress),
      child: this,
    );
  }

  /// Slide in from bottom (0.0 = fully visible, 1.0 = off screen bottom)
  /// Performance: Common animation pattern, single widget
  Widget slideFromBottom(double progress) {
    return FractionalTranslation(
      translation: Offset(0, 1 - progress),
      child: this,
    );
  }
}
