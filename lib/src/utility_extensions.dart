import 'package:flutter/material.dart';

/// SafeArea extensions
extension SafeAreaExtensions on Widget {
  /// Wraps widget in SafeArea
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
    EdgeInsets minimum = EdgeInsets.zero,
  }) => SafeArea(
    top: top,
    bottom: bottom,
    left: left,
    right: right,
    minimum: minimum,
    child: this,
  );

  /// SafeArea for top only (common for status bar)
  Widget safeTop() =>
      SafeArea(bottom: false, left: false, right: false, child: this);

  /// SafeArea for bottom only (common for navigation bar)
  Widget safeBottom() =>
      SafeArea(top: false, left: false, right: false, child: this);

  /// SafeArea for horizontal edges
  Widget safeHorizontal() => SafeArea(top: false, bottom: false, child: this);
}

/// Hero animation extensions
extension HeroExtensions on Widget {
  /// Wraps widget in Hero for shared element transitions
  Widget hero({
    required String tag,
    CreateRectTween? createRectTween,
    HeroFlightShuttleBuilder? flightShuttleBuilder,
    HeroPlaceholderBuilder? placeholderBuilder,
    bool transitionOnUserGestures = false,
  }) => Hero(
    tag: tag,
    createRectTween: createRectTween,
    flightShuttleBuilder: flightShuttleBuilder,
    placeholderBuilder: placeholderBuilder,
    transitionOnUserGestures: transitionOnUserGestures,
    child: this,
  );
}

/// Material wrapper extensions
extension MaterialExtensions on Widget {
  /// Wraps widget in Material
  Widget material({
    Color? color,
    double elevation = 0,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
  }) => Material(
    color: color,
    elevation: elevation,
    borderRadius: borderRadius,
    shape: shape,
    clipBehavior: clipBehavior,
    child: this,
  );

  /// Wraps widget in Card
  Widget card({
    Color? color,
    double? elevation,
    ShapeBorder? shape,
    EdgeInsetsGeometry? margin,
    Clip clipBehavior = Clip.none,
  }) => Card(
    color: color,
    elevation: elevation,
    shape: shape,
    margin: margin,
    clipBehavior: clipBehavior,
    child: this,
  );
}

/// Baseline alignment extension
extension BaselineExtensions on Widget {
  /// Aligns widget to baseline
  Widget baseline({
    required double baseline,
    required TextBaseline baselineType,
  }) => Baseline(baseline: baseline, baselineType: baselineType, child: this);
}

/// Sliver extensions
extension SliverExtensions on Widget {
  /// Converts widget to SliverToBoxAdapter
  Widget toSliverBox() => SliverToBoxAdapter(child: this);

  /// Wraps widget in SliverFillRemaining
  Widget sliverFillRemaining({
    bool hasScrollBody = true,
    bool fillOverscroll = false,
  }) => SliverFillRemaining(
    hasScrollBody: hasScrollBody,
    fillOverscroll: fillOverscroll,
    child: this,
  );

  /// Wraps widget in SliverPadding
  Widget sliverPadding(EdgeInsetsGeometry padding) =>
      SliverPadding(padding: padding, sliver: this);
}

/// List/Grid Sliver builders
extension SliverListExtensions on List<Widget> {
  /// Converts list to SliverList
  Widget toSliverList() => SliverList(delegate: SliverChildListDelegate(this));

  /// Converts list to SliverGrid with fixed cross axis count
  Widget toSliverGrid({
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  }) => SliverGrid(
    delegate: SliverChildListDelegate(this),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    ),
  );
}

/// Scaffold utility extensions
extension ScaffoldExtensions on Widget {
  /// Wraps widget in Scaffold with optional properties
  Widget scaffold({
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
    bool extendBody = false,
    bool extendBodyBehindAppBar = false,
  }) => Scaffold(
    appBar: appBar,
    body: this,
    floatingActionButton: floatingActionButton,
    drawer: drawer,
    endDrawer: endDrawer,
    bottomNavigationBar: bottomNavigationBar,
    backgroundColor: backgroundColor,
    extendBody: extendBody,
    extendBodyBehindAppBar: extendBodyBehindAppBar,
  );
}

/// Keyboard dismissal extension
extension KeyboardExtensions on Widget {
  /// Wraps widget with tap to dismiss keyboard
  Widget dismissKeyboard() => GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}

/// Rotated box extension
extension RotatedBoxExtensions on Widget {
  /// Rotates widget in 90-degree increments
  Widget rotatedBox(int quarterTurns) =>
      RotatedBox(quarterTurns: quarterTurns, child: this);
}
