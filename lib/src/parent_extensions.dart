import 'package:flutter/widgets.dart';

extension ParentExtension on Widget {
  Widget parent(Widget Function(Widget child) builder) => builder(this);
}
