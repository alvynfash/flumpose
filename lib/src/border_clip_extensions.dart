import 'package:flutter/material.dart';

extension BorderExtension on Widget {
  Widget border(Border border) => Container(
    decoration: BoxDecoration(border: border),
    child: this,
  );
}

extension BorderRadiusExtension on Widget {
  Widget borderRadius(BorderRadius radius) =>
      ClipRRect(borderRadius: radius, child: this);
}

extension ClipRRectExtension on Widget {
  Widget clipRRect(BorderRadius radius) =>
      ClipRRect(borderRadius: radius, child: this);
}

extension ClipOvalExtension on Widget {
  Widget clipOval() => ClipOval(child: this);
}

extension ElevationExtension on Widget {
  Widget elevation(
    double value, {
    Color? color,
    BorderRadius? borderRadius,
    bool clip = false,
    Clip clipBehavior = Clip.none,
  }) => Material(
    color: color ?? Colors.transparent,
    elevation: value,
    borderRadius: borderRadius,
    clipBehavior: clip ? Clip.antiAlias : clipBehavior,
    child: this,
  );
}

extension BoxShadowExtension on Widget {
  Widget boxShadow({
    Color color = Colors.black26,
    double blurRadius = 6,
    Offset offset = const Offset(0, 2),
  }) => Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(color: color, blurRadius: blurRadius, offset: offset),
      ],
    ),
    child: this,
  );
}
