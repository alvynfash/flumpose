import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on Text {
  Text fontSize(double size) => Text(
    data ?? '',
    style: (style ?? const TextStyle()).copyWith(fontSize: size),
    textAlign: textAlign,
  );
  Text color(Color color) => Text(
    data ?? '',
    style: (style ?? const TextStyle()).copyWith(color: color),
    textAlign: textAlign,
  );
  Text bold() => Text(
    data ?? '',
    style: (style ?? const TextStyle()).copyWith(fontWeight: FontWeight.bold),
    textAlign: textAlign,
  );
  Text italic() => Text(
    data ?? '',
    style: (style ?? const TextStyle()).copyWith(fontStyle: FontStyle.italic),
    textAlign: textAlign,
  );
  Text textColor(Color color) => Text(
    data ?? '',
    style: (style ?? const TextStyle()).copyWith(color: color),
    textAlign: textAlign,
  );
}
