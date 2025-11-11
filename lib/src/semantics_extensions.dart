import 'package:flutter/widgets.dart';

extension SemanticsExtensions on Widget {
  Widget semanticsLabel(String label, {bool excludeSemantics = false}) =>
      Semantics(label: label, excludeSemantics: excludeSemantics, child: this);
}
