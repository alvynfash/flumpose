import 'package:flutter/widgets.dart';

/// Responsive extensions based on MediaQuery
extension ResponsiveExtensions on Widget {
  /// Wraps widget with MediaQuery-based conditional rendering
  Widget responsive({
    Widget Function(BuildContext, BoxConstraints)? builder,
    double? maxWidth,
    double? maxHeight,
  }) => LayoutBuilder(
    builder: (context, constraints) {
      if (maxWidth != null && constraints.maxWidth > maxWidth) {
        return SizedBox(width: maxWidth, child: this);
      }
      if (maxHeight != null && constraints.maxHeight > maxHeight) {
        return SizedBox(height: maxHeight, child: this);
      }
      return builder?.call(context, constraints) ?? this;
    },
  );

  /// Shows widget only on mobile screens (< 600dp)
  Widget onlyMobile() => LayoutBuilder(
    builder: (context, constraints) =>
        constraints.maxWidth < 600 ? this : const SizedBox.shrink(),
  );

  /// Shows widget only on tablet screens (600-900dp)
  Widget onlyTablet() => LayoutBuilder(
    builder: (context, constraints) =>
        constraints.maxWidth >= 600 && constraints.maxWidth < 900
        ? this
        : const SizedBox.shrink(),
  );

  /// Shows widget only on desktop screens (>= 900dp)
  Widget onlyDesktop() => LayoutBuilder(
    builder: (context, constraints) =>
        constraints.maxWidth >= 900 ? this : const SizedBox.shrink(),
  );

  /// Adapts widget based on screen size with custom breakpoints
  Widget adaptiveSize({
    double? mobile,
    double? tablet,
    double? desktop,
    double mobileBreakpoint = 600,
    double tabletBreakpoint = 900,
  }) => LayoutBuilder(
    builder: (context, constraints) {
      double size;
      if (constraints.maxWidth < mobileBreakpoint && mobile != null) {
        size = mobile;
      } else if (constraints.maxWidth < tabletBreakpoint && tablet != null) {
        size = tablet;
      } else if (desktop != null) {
        size = desktop;
      } else {
        return this;
      }

      return SizedBox(width: size, height: size, child: this);
    },
  );

  /// Scales widget based on screen width
  Widget scaleWithScreen({
    double baseWidth = 375,
    double? maxScale,
    double? minScale,
  }) => LayoutBuilder(
    builder: (context, constraints) {
      var scale = constraints.maxWidth / baseWidth;
      if (maxScale != null && scale > maxScale) scale = maxScale;
      if (minScale != null && scale < minScale) scale = minScale;

      return Transform.scale(scale: scale, child: this);
    },
  );

  /// Makes widget constrained to a maximum width (useful for responsive layouts)
  Widget maxWidthBox(double maxWidth, {AlignmentGeometry? alignment}) => Align(
    alignment: alignment ?? Alignment.center,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: this,
    ),
  );

  /// Adds horizontal padding based on screen width
  Widget responsivePadding({
    double mobilePadding = 16,
    double tabletPadding = 32,
    double desktopPadding = 64,
    double mobileBreakpoint = 600,
    double tabletBreakpoint = 900,
  }) => LayoutBuilder(
    builder: (context, constraints) {
      double padding;
      if (constraints.maxWidth < mobileBreakpoint) {
        padding = mobilePadding;
      } else if (constraints.maxWidth < tabletBreakpoint) {
        padding = tabletPadding;
      } else {
        padding = desktopPadding;
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );
    },
  );

  /// Makes widget fill available space with aspect ratio constraint
  Widget fillWithAspectRatio(double aspectRatio) => AspectRatio(
    aspectRatio: aspectRatio,
    child: SizedBox.expand(child: this),
  );
}

/// Breakpoint helper for responsive design
class Breakpoint {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  /// Gets the current breakpoint category
  static BreakpointCategory getCategory(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobile) return BreakpointCategory.mobile;
    if (width < tablet) return BreakpointCategory.tablet;
    if (width < desktop) return BreakpointCategory.desktop;
    return BreakpointCategory.large;
  }

  /// Checks if current screen is mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobile;

  /// Checks if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobile && width < tablet;
  }

  /// Checks if current screen is desktop
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;
}

/// Screen size categories
enum BreakpointCategory { mobile, tablet, desktop, large }

/// Extension on BuildContext for responsive helpers
extension ResponsiveContext on BuildContext {
  /// Gets screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Gets screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Checks if screen is mobile
  bool get isMobile => screenWidth < Breakpoint.mobile;

  /// Checks if screen is tablet
  bool get isTablet =>
      screenWidth >= Breakpoint.mobile && screenWidth < Breakpoint.tablet;

  /// Checks if screen is desktop
  bool get isDesktop => screenWidth >= Breakpoint.tablet;

  /// Gets responsive value based on screen size
  T responsiveValue<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}
