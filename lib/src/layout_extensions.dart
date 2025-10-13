import 'package:flutter/widgets.dart';

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
  Widget pad(double value) {
    // Reuse const EdgeInsets for common values (performance optimization)
    EdgeInsets padding;
    switch (value) {
      case 0:
        padding = ConstPadding.zero;
        break;
      case 2:
        padding = ConstPadding.all2;
        break;
      case 4:
        padding = ConstPadding.all4;
        break;
      case 8:
        padding = ConstPadding.all8;
        break;
      case 12:
        padding = ConstPadding.all12;
        break;
      case 16:
        padding = ConstPadding.all16;
        break;
      case 20:
        padding = ConstPadding.all20;
        break;
      case 24:
        padding = ConstPadding.all24;
        break;
      case 32:
        padding = ConstPadding.all32;
        break;
      default:
        padding = EdgeInsets.all(value);
    }
    return Padding(padding: padding, child: this);
  }

  /// Add padding with EdgeInsets - use for custom padding configurations
  Widget padding(EdgeInsets value) => Padding(padding: value, child: this);

  /// Horizontal padding - optimized for common values
  Widget padH(double value) {
    EdgeInsets padding;
    switch (value) {
      case 4:
        padding = ConstPadding.h4;
        break;
      case 8:
        padding = ConstPadding.h8;
        break;
      case 12:
        padding = ConstPadding.h12;
        break;
      case 16:
        padding = ConstPadding.h16;
        break;
      case 20:
        padding = ConstPadding.h20;
        break;
      case 24:
        padding = ConstPadding.h24;
        break;
      default:
        padding = EdgeInsets.symmetric(horizontal: value);
    }
    return Padding(padding: padding, child: this);
  }

  /// Vertical padding - optimized for common values
  Widget padV(double value) {
    EdgeInsets padding;
    switch (value) {
      case 4:
        padding = ConstPadding.v4;
        break;
      case 8:
        padding = ConstPadding.v8;
        break;
      case 12:
        padding = ConstPadding.v12;
        break;
      case 16:
        padding = ConstPadding.v16;
        break;
      case 20:
        padding = ConstPadding.v20;
        break;
      case 24:
        padding = ConstPadding.v24;
        break;
      default:
        padding = EdgeInsets.symmetric(vertical: value);
    }
    return Padding(padding: padding, child: this);
  }

  /// Symmetric padding
  Widget padSymmetric({double? horizontal, double? vertical}) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    child: this,
  );

  /// Specific side padding
  Widget padOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );
}

extension MarginExtension on Widget {
  /// Add margin with double value - optimized to reuse const EdgeInsets for common values
  /// Common optimized values: 0, 4, 8, 12, 16, 20, 24, 32
  Widget margin(double value) {
    // Reuse const EdgeInsets for performance
    EdgeInsets edgeInsets;
    switch (value) {
      case 0:
        edgeInsets = ConstPadding.zero;
        break;
      case 4:
        edgeInsets = ConstPadding.all4;
        break;
      case 8:
        edgeInsets = ConstPadding.all8;
        break;
      case 12:
        edgeInsets = ConstPadding.all12;
        break;
      case 16:
        edgeInsets = ConstPadding.all16;
        break;
      case 20:
        edgeInsets = ConstPadding.all20;
        break;
      case 24:
        edgeInsets = ConstPadding.all24;
        break;
      case 32:
        edgeInsets = ConstPadding.all32;
        break;
      default:
        edgeInsets = EdgeInsets.all(value);
    }
    return Container(margin: edgeInsets, child: this);
  }

  /// Add margin with EdgeInsets - use for custom margin configurations
  Widget marginAll(EdgeInsets value) => Container(margin: value, child: this);

  /// Horizontal margin - optimized for common values
  Widget marginH(double value) {
    EdgeInsets margin;
    switch (value) {
      case 4:
        margin = ConstPadding.h4;
        break;
      case 8:
        margin = ConstPadding.h8;
        break;
      case 12:
        margin = ConstPadding.h12;
        break;
      case 16:
        margin = ConstPadding.h16;
        break;
      case 20:
        margin = ConstPadding.h20;
        break;
      case 24:
        margin = ConstPadding.h24;
        break;
      default:
        margin = EdgeInsets.symmetric(horizontal: value);
    }
    return Container(margin: margin, child: this);
  }

  /// Vertical margin - optimized for common values
  Widget marginV(double value) {
    EdgeInsets margin;
    switch (value) {
      case 4:
        margin = ConstPadding.v4;
        break;
      case 8:
        margin = ConstPadding.v8;
        break;
      case 12:
        margin = ConstPadding.v12;
        break;
      case 16:
        margin = ConstPadding.v16;
        break;
      case 20:
        margin = ConstPadding.v20;
        break;
      case 24:
        margin = ConstPadding.v24;
        break;
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
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);
  Widget alignCenter() => Align(alignment: Alignment.center, child: this);
  Widget alignTopLeft() => Align(alignment: Alignment.topLeft, child: this);
  Widget alignTopCenter() => Align(alignment: Alignment.topCenter, child: this);
  Widget alignTopRight() => Align(alignment: Alignment.topRight, child: this);
  Widget alignCenterLeft() =>
      Align(alignment: Alignment.centerLeft, child: this);
  Widget alignCenterRight() =>
      Align(alignment: Alignment.centerRight, child: this);
  Widget alignBottomLeft() =>
      Align(alignment: Alignment.bottomLeft, child: this);
  Widget alignBottomCenter() =>
      Align(alignment: Alignment.bottomCenter, child: this);
  Widget alignBottomRight() =>
      Align(alignment: Alignment.bottomRight, child: this);
}

extension SizeExtensions on Widget {
  Widget width(double w) => SizedBox(width: w, child: this);
  Widget height(double h) => SizedBox(height: h, child: this);
  Widget size(double w, double h) => SizedBox(width: w, height: h, child: this);
  Widget constrained(BoxConstraints constraints) =>
      ConstrainedBox(constraints: constraints, child: this);

  /// Create a square-sized box (specific dimension)
  Widget squareBox(double size) =>
      SizedBox.square(dimension: size, child: this);
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
