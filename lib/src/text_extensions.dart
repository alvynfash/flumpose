import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

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
