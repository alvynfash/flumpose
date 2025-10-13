import 'package:flutter/widgets.dart';

extension AnimationExtensions on Widget {
  Widget fade({Duration duration = const Duration(milliseconds: 300)}) =>
      AnimatedOpacity(opacity: 1.0, duration: duration, child: this);
}
