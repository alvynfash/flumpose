import 'package:flutter/material.dart';

/// Optimized decoration builder that accumulates decoration properties
/// without creating intermediate Container widgets.
///
/// Performance: Instead of wrapping widgets multiple times with Container,
/// build a single BoxDecoration with all properties, then wrap once.
///
/// Example:
/// ```dart
/// myWidget.decorate((d) => d
///   .color(Colors.blue)
///   .border(Border.all())
///   .borderRadius(BorderRadius.circular(8))
///   .shadow(BoxShadow(...))
/// )
/// ```
///
/// This creates only ONE Container instead of multiple nested Containers.
class DecorationBuilder {
  Color? _color;
  Border? _border;
  BorderRadius? _borderRadius;
  List<BoxShadow>? _boxShadow;
  Gradient? _gradient;
  DecorationImage? _image;
  BoxShape _shape = BoxShape.rectangle;
  BlendMode? _backgroundBlendMode;

  /// Sets background color
  DecorationBuilder color(Color color) {
    _color = color;
    return this;
  }

  /// Sets border
  DecorationBuilder border(Border border) {
    _border = border;
    return this;
  }

  /// Sets border with all sides having the same color and width
  DecorationBuilder borderAll({
    Color color = const Color(0xFF000000),
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
  }) {
    _border = Border.all(color: color, width: width, style: style);
    return this;
  }

  /// Sets border radius
  DecorationBuilder borderRadius(BorderRadius radius) {
    _borderRadius = radius;
    return this;
  }

  /// Sets circular border radius
  DecorationBuilder circular(double radius) {
    _borderRadius = BorderRadius.circular(radius);
    return this;
  }

  /// Adds a box shadow
  DecorationBuilder shadow(BoxShadow shadow) {
    _boxShadow = [...?_boxShadow, shadow];
    return this;
  }

  /// Adds a simple box shadow with common defaults
  DecorationBuilder simpleShadow({
    Color color = Colors.black26,
    double blurRadius = 6,
    Offset offset = const Offset(0, 2),
    double spreadRadius = 0,
  }) {
    return shadow(
      BoxShadow(
        color: color,
        blurRadius: blurRadius,
        offset: offset,
        spreadRadius: spreadRadius,
      ),
    );
  }

  /// Sets gradient
  DecorationBuilder gradient(Gradient gradient) {
    _gradient = gradient;
    return this;
  }

  /// Sets linear gradient
  DecorationBuilder linearGradient({
    required List<Color> colors,
    Alignment begin = Alignment.topCenter,
    Alignment end = Alignment.bottomCenter,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
  }) {
    _gradient = LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
      stops: stops,
      tileMode: tileMode,
    );
    return this;
  }

  /// Sets radial gradient
  DecorationBuilder radialGradient({
    required List<Color> colors,
    Alignment center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
  }) {
    _gradient = RadialGradient(
      colors: colors,
      center: center,
      radius: radius,
      stops: stops,
      tileMode: tileMode,
    );
    return this;
  }

  /// Sets background image
  DecorationBuilder image(
    ImageProvider image, {
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
  }) {
    _image = DecorationImage(
      image: image,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
    );
    return this;
  }

  /// Sets box shape (rectangle or circle)
  DecorationBuilder shape(BoxShape shape) {
    _shape = shape;
    return this;
  }

  /// Makes the box circular (shorthand for shape(BoxShape.circle))
  DecorationBuilder circle() {
    _shape = BoxShape.circle;
    return this;
  }

  /// Sets background blend mode
  DecorationBuilder blendMode(BlendMode mode) {
    _backgroundBlendMode = mode;
    return this;
  }

  /// Builds the final BoxDecoration
  BoxDecoration build() {
    return BoxDecoration(
      color: _color,
      border: _border,
      borderRadius: _borderRadius,
      boxShadow: _boxShadow,
      gradient: _gradient,
      image: _image,
      shape: _shape,
      backgroundBlendMode: _backgroundBlendMode,
    );
  }
}

/// Extension to use DecorationBuilder with widgets
extension DecorationBuilderExtension on Widget {
  /// Applies decoration using a builder pattern to minimize allocations
  ///
  /// Performance: Creates only ONE Container with complete decoration
  /// instead of multiple nested Containers.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').decorate((d) => d
  ///   .color(Colors.blue)
  ///   .border(Border.all())
  ///   .circular(8)
  ///   .simpleShadow()
  /// )
  /// ```
  Widget decorate(DecorationBuilder Function(DecorationBuilder) builder) {
    final decoration = builder(DecorationBuilder()).build();
    return Container(decoration: decoration, child: this);
  }

  /// Applies decoration with optional padding in a single Container
  ///
  /// Performance: Even better than separate pad() + decorate() calls
  /// as it creates only one Container for both decoration and padding.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').decorateWithPadding(
  ///   padding: EdgeInsets.all(16),
  ///   builder: (d) => d.color(Colors.blue).circular(8),
  /// )
  /// ```
  Widget decorateWithPadding({
    required EdgeInsets padding,
    required DecorationBuilder Function(DecorationBuilder) builder,
  }) {
    final decoration = builder(DecorationBuilder()).build();
    return Container(decoration: decoration, padding: padding, child: this);
  }
}
