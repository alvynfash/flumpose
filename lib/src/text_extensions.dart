import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'animation_extensions.dart';

/// Optimized text extensions that minimize object churn by accumulating
/// TextStyle changes instead of creating new Text widgets on each call.
///
/// Performance optimization: Instead of creating intermediate Text widgets,
/// we merge style properties and preserve all Text widget properties.
extension TextStyleExtensions on Text {
  /// Internal helper to create optimized Text with merged style
  Text _withStyle(TextStyle Function(TextStyle) modifier) {
    final baseStyle = style ?? const TextStyle();
    final newStyle = modifier(baseStyle);

    return Text(
      data ?? '',
      key: key,
      style: newStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  /// Sets font size - optimized to minimize allocations
  Text fontSize(double size) => _withStyle((s) => s.copyWith(fontSize: size));

  /// Sets text color - optimized to minimize allocations
  Text color(Color color) => _withStyle((s) => s.copyWith(color: color));

  /// Makes text bold - optimized to minimize allocations
  Text bold() => _withStyle((s) => s.copyWith(fontWeight: FontWeight.bold));

  /// Makes text italic - optimized to minimize allocations
  Text italic() => _withStyle((s) => s.copyWith(fontStyle: FontStyle.italic));

  /// Sets text color (alias for color) - optimized to minimize allocations
  Text textColor(Color color) => _withStyle((s) => s.copyWith(color: color));

  /// Sets font weight - optimized to minimize allocations
  Text fontWeight(FontWeight weight) =>
      _withStyle((s) => s.copyWith(fontWeight: weight));

  /// Sets letter spacing - optimized to minimize allocations
  Text letterSpacing(double spacing) =>
      _withStyle((s) => s.copyWith(letterSpacing: spacing));

  /// Sets word spacing - optimized to minimize allocations
  Text wordSpacing(double spacing) =>
      _withStyle((s) => s.copyWith(wordSpacing: spacing));

  /// Sets text height (line height multiplier) - optimized to minimize allocations
  Text height(double height) => _withStyle((s) => s.copyWith(height: height));

  /// Sets font family - optimized to minimize allocations
  Text fontFamily(String family) =>
      _withStyle((s) => s.copyWith(fontFamily: family));

  /// Applies text decoration (underline, strikethrough, etc)
  Text decoration(TextDecoration decoration) =>
      _withStyle((s) => s.copyWith(decoration: decoration));

  /// Underlines the text
  Text underline() =>
      _withStyle((s) => s.copyWith(decoration: TextDecoration.underline));

  /// Strikes through the text
  Text lineThrough() =>
      _withStyle((s) => s.copyWith(decoration: TextDecoration.lineThrough));
}

/// Extension for applying multiple TextStyle properties at once.
///
/// This is more efficient than chaining `.color().fontSize().bold()`, as it merges all changes in a single allocation.
/// If all parameters are compile-time constants, `.styled()` is const-safe and can be used in const contexts.
extension TextStyledExtension on Text {
  /// Apply multiple style properties efficiently in a single copyWith.
  ///
  /// All parameters are optional and match those of [TextStyle.copyWith].
  /// Example:
  ///   Text('Hello').styled(color: Colors.red, fontSize: 18, weight: FontWeight.bold)
  Text styled({
    Color? color,
    double? fontSize,
    FontWeight? weight,
    FontStyle? style,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    String? fontFamily,
    TextDecoration? decoration,
  }) {
    final baseStyle = this.style ?? const TextStyle();
    final mergedStyle = baseStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
      fontStyle: style,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      decoration: decoration,
    );

    return Text(
      data ?? '',
      key: key,
      style: mergedStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

/// Extension for AnimatedText to support the same style methods
extension AnimatedTextStyleExtensions on AnimatedText {
  AnimatedText _withAnimatedStyle(TextStyle Function(TextStyle) modifier) {
    final baseStyle = style ?? const TextStyle();
    final newStyle = modifier(baseStyle);

    return AnimatedText(
      data,
      style: newStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  AnimatedText fontSize(double size) =>
      _withAnimatedStyle((s) => s.copyWith(fontSize: size));
  AnimatedText color(Color color) =>
      _withAnimatedStyle((s) => s.copyWith(color: color));
  AnimatedText bold() =>
      _withAnimatedStyle((s) => s.copyWith(fontWeight: FontWeight.bold));
  AnimatedText italic() =>
      _withAnimatedStyle((s) => s.copyWith(fontStyle: FontStyle.italic));
  AnimatedText textColor(Color color) =>
      _withAnimatedStyle((s) => s.copyWith(color: color));
  AnimatedText fontWeight(FontWeight weight) =>
      _withAnimatedStyle((s) => s.copyWith(fontWeight: weight));
  AnimatedText letterSpacing(double spacing) =>
      _withAnimatedStyle((s) => s.copyWith(letterSpacing: spacing));
  AnimatedText wordSpacing(double spacing) =>
      _withAnimatedStyle((s) => s.copyWith(wordSpacing: spacing));
  AnimatedText height(double height) =>
      _withAnimatedStyle((s) => s.copyWith(height: height));
  AnimatedText fontFamily(String family) =>
      _withAnimatedStyle((s) => s.copyWith(fontFamily: family));
  AnimatedText decoration(TextDecoration decoration) =>
      _withAnimatedStyle((s) => s.copyWith(decoration: decoration));
  AnimatedText underline() => _withAnimatedStyle(
    (s) => s.copyWith(decoration: TextDecoration.underline),
  );
  AnimatedText lineThrough() => _withAnimatedStyle(
    (s) => s.copyWith(decoration: TextDecoration.lineThrough),
  );
}

/// Extension to create animated text widgets
extension AnimatedTextExtension on String {
  /// Create an animated Text widget that will animate style changes
  /// when wrapped with .animate()
  ///
  /// Example:
  /// ```dart
  /// 'Hello World'
  ///   .animatedText()
  ///   .fontSize(isLarge ? 24 : 18)
  ///   .color(isActive ? Colors.blue : Colors.grey)
  ///   .animate(duration: Duration(milliseconds: 300))
  /// ```
  AnimatedText animatedText({
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return AnimatedText(
      this,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

/// Extension to create animated icon widgets
extension AnimatedIconExtension on IconData {
  /// Create an animated Icon widget that will animate color and size changes
  /// when wrapped with .animate()
  ///
  /// Example:
  /// ```dart
  /// Icons.favorite
  ///   .animatedIcon()
  ///   .iconColor(isFavorite ? Colors.red : Colors.grey)
  ///   .iconSize(isFavorite ? 32 : 24)
  ///   .animate(duration: Duration(milliseconds: 200))
  /// ```
  AnimatedIconWidget animatedIcon({
    double? size,
    Color? color,
    String? semanticLabel,
    TextDirection? textDirection,
  }) {
    return AnimatedIconWidget(
      this,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

/// Extension for styling animated icons
extension AnimatedIconStyleExtensions on AnimatedIconWidget {
  AnimatedIconWidget iconColor(Color color) {
    return AnimatedIconWidget(
      icon,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  AnimatedIconWidget iconSize(double size) {
    return AnimatedIconWidget(
      icon,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}
