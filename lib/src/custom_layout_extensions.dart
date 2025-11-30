import 'package:flutter/material.dart';

/// Custom layout and positioning extensions
extension CustomLayoutExtensions on Widget {
  /// Wrap in LayoutBuilder for responsive layouts
  /// Performance: Single LayoutBuilder wrapper
  Widget layoutBuilder(
    Widget Function(BuildContext context, BoxConstraints constraints) builder,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) => builder(context, constraints),
    );
  }

  /// Wrap in CustomSingleChildLayout
  /// Performance: Single CustomSingleChildLayout for custom positioning
  Widget customLayout({required SingleChildLayoutDelegate delegate}) {
    return CustomSingleChildLayout(delegate: delegate, child: this);
  }

  /// Wrap in Offstage (hide without removing from tree)
  /// Performance: Zero-cost hiding (widget stays in tree but not painted)
  Widget offstage({bool offstage = true}) {
    return Offstage(offstage: offstage, child: this);
  }

  /// Wrap in OverflowBox for overflow control
  /// Performance: Single OverflowBox wrapper
  Widget overflowBox({
    AlignmentGeometry alignment = Alignment.center,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return OverflowBox(
      alignment: alignment,
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
      child: this,
    );
  }

  /// Wrap in SizedOverflowBox
  /// Performance: Single SizedOverflowBox wrapper
  Widget sizedOverflowBox({
    required Size size,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return SizedOverflowBox(size: size, alignment: alignment, child: this);
  }

  /// Wrap in LimitedBox
  /// Performance: Single LimitedBox for unconstrained contexts
  Widget limitedBox({
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) {
    return LimitedBox(maxWidth: maxWidth, maxHeight: maxHeight, child: this);
  }

  /// Wrap in IntrinsicHeight
  /// Performance: Note - can be expensive, use sparingly
  Widget intrinsicHeight() {
    return IntrinsicHeight(child: this);
  }

  /// Wrap in IntrinsicWidth
  /// Performance: Note - can be expensive, use sparingly
  Widget intrinsicWidth({double? stepWidth, double? stepHeight}) {
    return IntrinsicWidth(
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: this,
    );
  }

  /// Wrap in Baseline for baseline alignment
  /// Performance: Single Baseline wrapper
  Widget baselineAlign({
    required double baseline,
    required TextBaseline baselineType,
  }) {
    return Baseline(
      baseline: baseline,
      baselineType: baselineType,
      child: this,
    );
  }

  /// Wrap in CustomPaint for custom painting
  /// Performance: Single CustomPaint wrapper
  Widget customPaint({
    CustomPainter? painter,
    CustomPainter? foregroundPainter,
    Size size = Size.zero,
    bool isComplex = false,
    bool willChange = false,
  }) {
    return CustomPaint(
      painter: painter,
      foregroundPainter: foregroundPainter,
      size: size,
      isComplex: isComplex,
      willChange: willChange,
      child: this,
    );
  }

  /// Wrap in RepaintBoundary for performance optimization
  /// Performance: Isolates repaints to this subtree
  Widget repaintBoundary() {
    return RepaintBoundary(child: this);
  }

  /// Wrap in PhysicalModel for elevation and shadows
  /// Performance: Single PhysicalModel wrapper
  Widget physicalModel({
    required Color color,
    double elevation = 0.0,
    Color shadowColor = const Color(0xFF000000),
    Clip clipBehavior = Clip.none,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
  }) {
    return PhysicalModel(
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      clipBehavior: clipBehavior,
      borderRadius: borderRadius ?? BorderRadius.zero,
      shape: shape != null ? BoxShape.rectangle : BoxShape.rectangle,
      child: this,
    );
  }

  /// Wrap in PhysicalShape for custom shaped elevation
  /// Performance: Single PhysicalShape wrapper
  Widget physicalShape({
    required ShapeBorder shape,
    required Color color,
    double elevation = 0.0,
    Color shadowColor = const Color(0xFF000000),
    Clip clipBehavior = Clip.none,
  }) {
    return PhysicalShape(
      clipper: ShapeBorderClipper(shape: shape),
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      clipBehavior: clipBehavior,
      child: this,
    );
  }
}

/// List layout extensions
extension ListLayoutExtensions on List<Widget> {
  /// Convert to ListView with custom options
  /// Performance: Single ListView widget
  Widget toListView({
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) {
    return ListView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemExtent: itemExtent,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      children: this,
    );
  }

  /// Convert to GridView with cross axis count
  /// Performance: Single GridView widget
  Widget toGridView({
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
  }) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      children: this,
    );
  }
}
