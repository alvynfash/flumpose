import 'package:flutter/widgets.dart';
import 'animation_extensions.dart';

/// Const-optimized padding values for reuse across the app
/// These reduce memory allocation by reusing const EdgeInsets instances
class ConstPadding {
  const ConstPadding._();

  static const zero = EdgeInsets.zero;
  static const all2 = EdgeInsets.all(2);
  static const all4 = EdgeInsets.all(4);
  static const all8 = EdgeInsets.all(8);
  static const all12 = EdgeInsets.all(12);
  static const all16 = EdgeInsets.all(16);
  static const all20 = EdgeInsets.all(20);
  static const all24 = EdgeInsets.all(24);
  static const all32 = EdgeInsets.all(32);

  static const h4 = EdgeInsets.symmetric(horizontal: 4);
  static const h8 = EdgeInsets.symmetric(horizontal: 8);
  static const h12 = EdgeInsets.symmetric(horizontal: 12);
  static const h16 = EdgeInsets.symmetric(horizontal: 16);
  static const h20 = EdgeInsets.symmetric(horizontal: 20);
  static const h24 = EdgeInsets.symmetric(horizontal: 24);

  static const v4 = EdgeInsets.symmetric(vertical: 4);
  static const v8 = EdgeInsets.symmetric(vertical: 8);
  static const v12 = EdgeInsets.symmetric(vertical: 12);
  static const v16 = EdgeInsets.symmetric(vertical: 16);
  static const v20 = EdgeInsets.symmetric(vertical: 20);
  static const v24 = EdgeInsets.symmetric(vertical: 24);
}

extension PaddingExtension on Widget {
  /// Add padding with double value - optimized to reuse const EdgeInsets for common values
  /// Common optimized values: 0, 2, 4, 8, 12, 16, 20, 24, 32
  /// Set [animate] to true to animate padding changes
  Widget pad(double value, {bool animate = false}) {
    final EdgeInsets padding;
    switch (value) {
      case 0:
        padding = ConstPadding.zero;
      case 2:
        padding = ConstPadding.all2;
      case 4:
        padding = ConstPadding.all4;
      case 8:
        padding = ConstPadding.all8;
      case 12:
        padding = ConstPadding.all12;
      case 16:
        padding = ConstPadding.all16;
      case 20:
        padding = ConstPadding.all20;
      case 24:
        padding = ConstPadding.all24;
      case 32:
        padding = ConstPadding.all32;
      default:
        padding = EdgeInsets.all(value);
    }

    if (!animate) return Padding(padding: padding, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedPadding(
        padding: padding,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  /// Add padding with EdgeInsets - use for custom padding configurations
  /// Set [animate] to true to animate padding changes
  Widget padding(EdgeInsets value, {bool animate = false}) {
    if (!animate) return Padding(padding: value, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedPadding(
        padding: value,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  /// Horizontal padding - optimized for common values
  /// Set [animate] to true to animate padding changes
  Widget padH(double value, {bool animate = false}) {
    final EdgeInsets padding;
    switch (value) {
      case 4:
        padding = ConstPadding.h4;
      case 8:
        padding = ConstPadding.h8;
      case 12:
        padding = ConstPadding.h12;
      case 16:
        padding = ConstPadding.h16;
      case 20:
        padding = ConstPadding.h20;
      case 24:
        padding = ConstPadding.h24;
      default:
        padding = EdgeInsets.symmetric(horizontal: value);
    }

    if (!animate) return Padding(padding: padding, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedPadding(
        padding: padding,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  /// Vertical padding - optimized for common values
  /// Set [animate] to true to animate padding changes
  Widget padV(double value, {bool animate = false}) {
    final EdgeInsets padding;
    switch (value) {
      case 4:
        padding = ConstPadding.v4;
      case 8:
        padding = ConstPadding.v8;
      case 12:
        padding = ConstPadding.v12;
      case 16:
        padding = ConstPadding.v16;
      case 20:
        padding = ConstPadding.v20;
      case 24:
        padding = ConstPadding.v24;
      default:
        padding = EdgeInsets.symmetric(vertical: value);
    }

    if (!animate) return Padding(padding: padding, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedPadding(
        padding: padding,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  /// Symmetric padding
  /// Set [animate] to true to animate padding changes
  Widget padSymmetric({
    double? horizontal,
    double? vertical,
    bool animate = false,
  }) {
    final padding = EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    );

    if (!animate) return Padding(padding: padding, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedPadding(
        padding: padding,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  /// Specific side padding
  /// Set [animate] to true to animate padding changes
  Widget padOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
    bool animate = false,
  }) {
    final padding = EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );

    if (!animate) return Padding(padding: padding, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedPadding(
        padding: padding,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }
}

extension MarginExtension on Widget {
  /// Add margin with double value - optimized to reuse const EdgeInsets for common values
  /// Common optimized values: 0, 4, 8, 12, 16, 20, 24, 32
  Widget margin(double value) {
    final EdgeInsets edgeInsets;
    switch (value) {
      case 0:
        edgeInsets = ConstPadding.zero;
      case 4:
        edgeInsets = ConstPadding.all4;
      case 8:
        edgeInsets = ConstPadding.all8;
      case 12:
        edgeInsets = ConstPadding.all12;
      case 16:
        edgeInsets = ConstPadding.all16;
      case 20:
        edgeInsets = ConstPadding.all20;
      case 24:
        edgeInsets = ConstPadding.all24;
      case 32:
        edgeInsets = ConstPadding.all32;
      default:
        edgeInsets = EdgeInsets.all(value);
    }
    return Container(margin: edgeInsets, child: this);
  }

  /// Add margin with EdgeInsets - use for custom margin configurations
  Widget marginAll(EdgeInsets value) => Container(margin: value, child: this);

  /// Horizontal margin - optimized for common values
  Widget marginH(double value) {
    final EdgeInsets margin;
    switch (value) {
      case 4:
        margin = ConstPadding.h4;
      case 8:
        margin = ConstPadding.h8;
      case 12:
        margin = ConstPadding.h12;
      case 16:
        margin = ConstPadding.h16;
      case 20:
        margin = ConstPadding.h20;
      case 24:
        margin = ConstPadding.h24;
      default:
        margin = EdgeInsets.symmetric(horizontal: value);
    }
    return Container(margin: margin, child: this);
  }

  /// Vertical margin - optimized for common values
  Widget marginV(double value) {
    final EdgeInsets margin;
    switch (value) {
      case 4:
        margin = ConstPadding.v4;
      case 8:
        margin = ConstPadding.v8;
      case 12:
        margin = ConstPadding.v12;
      case 16:
        margin = ConstPadding.v16;
      case 20:
        margin = ConstPadding.v20;
      case 24:
        margin = ConstPadding.v24;
      default:
        margin = EdgeInsets.symmetric(vertical: value);
    }
    return Container(margin: margin, child: this);
  }

  /// Symmetric margin
  Widget marginSymmetric({double? horizontal, double? vertical}) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    child: this,
  );

  /// Specific side margin
  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Container(
    margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );
}

extension AlignmentExtension on Widget {
  /// Set [animate] to true to animate alignment changes
  Widget align(Alignment alignment, {bool animate = false}) {
    if (!animate) return Align(alignment: alignment, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedAlign(
        alignment: alignment,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  Widget alignCenter({bool animate = false}) =>
      align(Alignment.center, animate: animate);
  Widget alignTopLeft({bool animate = false}) =>
      align(Alignment.topLeft, animate: animate);
  Widget alignTopCenter({bool animate = false}) =>
      align(Alignment.topCenter, animate: animate);
  Widget alignTopRight({bool animate = false}) =>
      align(Alignment.topRight, animate: animate);
  Widget alignCenterLeft({bool animate = false}) =>
      align(Alignment.centerLeft, animate: animate);
  Widget alignCenterRight({bool animate = false}) =>
      align(Alignment.centerRight, animate: animate);
  Widget alignBottomLeft({bool animate = false}) =>
      align(Alignment.bottomLeft, animate: animate);
  Widget alignBottomCenter({bool animate = false}) =>
      align(Alignment.bottomCenter, animate: animate);
  Widget alignBottomRight({bool animate = false}) =>
      align(Alignment.bottomRight, animate: animate);
}

extension SizeExtensions on Widget {
  /// Set [animate] to true to animate size changes
  Widget width(double w, {bool animate = false}) {
    if (!animate) return SizedBox(width: w, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedContainer(
        width: w,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  /// Set [animate] to true to animate size changes
  Widget height(double h, {bool animate = false}) {
    if (!animate) return SizedBox(height: h, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedContainer(
        height: h,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  /// Set [animate] to true to animate size changes
  Widget size(double w, double h, {bool animate = false}) {
    if (!animate) return SizedBox(width: w, height: h, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedContainer(
        width: w,
        height: h,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }

  Widget constrained(BoxConstraints constraints) =>
      ConstrainedBox(constraints: constraints, child: this);

  /// Create a square-sized box (specific dimension)
  Widget squareBox(double size, {bool animate = false}) {
    if (!animate) return SizedBox.square(dimension: size, child: this);

    return AnimatedWrapper(
      builder: (config) => AnimatedContainer(
        width: size,
        height: size,
        duration: config.duration,
        curve: config.curve,
        child: this,
      ),
    );
  }
}

extension OverflowExtension on Widget {
  Widget overflow({Clip clip = Clip.hardEdge}) =>
      ClipRect(clipBehavior: clip, child: this);
}

extension ScrollableExtension on Widget {
  Widget scrollable({
    Axis axis = Axis.vertical,
    ScrollController? controller,
  }) => SingleChildScrollView(
    scrollDirection: axis,
    controller: controller,
    child: this,
  );
}
