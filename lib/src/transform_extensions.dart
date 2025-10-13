import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

extension TransformExtensions on Widget {
  Widget rotate(double angle, {Alignment alignment = Alignment.center}) =>
      Transform.rotate(angle: angle, alignment: alignment, child: this);
  Widget scaleWidget(double scale, {Alignment alignment = Alignment.center}) =>
      Transform.scale(scale: scale, alignment: alignment, child: this);
  Widget translate({double x = 0, double y = 0}) =>
      Transform.translate(offset: Offset(x, y), child: this);
  Widget transform(Matrix4 matrix, {Alignment? alignment}) =>
      Transform(transform: matrix, alignment: alignment, child: this);
}
