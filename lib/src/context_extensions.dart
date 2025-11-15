import 'package:flutter/material.dart';

/// Context extensions for accessing common properties and utilities
/// Performance-optimized to minimize allocations and use Flutter's recommended APIs
extension ContextExtensions on BuildContext {
  // ============================================================================
  // MediaQuery Extensions (using recommended sizeOf, paddingOf, etc.)
  // ============================================================================

  /// Get screen size - uses MediaQuery.sizeOf for better performance
  /// Only rebuilds when size changes
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Get screen width - uses MediaQuery.sizeOf for better performance
  double get width => MediaQuery.sizeOf(this).width;

  /// Get screen height - uses MediaQuery.sizeOf for better performance
  double get height => MediaQuery.sizeOf(this).height;

  /// Get screen padding (safe area insets) - uses MediaQuery.paddingOf
  /// Only rebuilds when padding changes
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Get view insets (keyboard height, etc.) - uses MediaQuery.viewInsetsOf
  /// Only rebuilds when view insets change
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Get view padding - uses MediaQuery.viewPaddingOf
  /// Only rebuilds when view padding changes
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// Get device pixel ratio - uses MediaQuery.devicePixelRatioOf
  /// Only rebuilds when device pixel ratio changes
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// Get text scaler - uses MediaQuery.textScalerOf
  /// Only rebuilds when text scaler changes
  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  /// Get orientation - uses MediaQuery.orientationOf
  /// Only rebuilds when orientation changes
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Check if orientation is portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Check if orientation is landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Get platform brightness - uses MediaQuery.platformBrightnessOf
  /// Only rebuilds when brightness changes
  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  /// Check if platform is in dark mode
  bool get isDarkMode => platformBrightness == Brightness.dark;

  /// Check if platform is in light mode
  bool get isLightMode => platformBrightness == Brightness.light;

  // ============================================================================
  // Responsive Breakpoints
  // ============================================================================

  /// Get the shortest side of the screen
  double get shortestSide => screenSize.shortestSide;

  /// Get the longest side of the screen
  double get longestSide => screenSize.longestSide;

  // ============================================================================
  // Responsive Helpers
  // ============================================================================

  /// Get screen width (uses MediaQuery.of for compatibility with responsive logic)
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height (uses MediaQuery.of for compatibility with responsive logic)
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if screen is mobile (width < 600)
  bool get isMobile => screenWidth < 600;

  /// Check if screen is tablet (width >= 600 && < 900)
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  /// Check if screen is desktop (width >= 900)
  bool get isDesktop => screenWidth >= 900;

  /// Get responsive value based on screen size
  /// Returns mobile value for width < 600
  /// Returns tablet value for width >= 600 && < 900
  /// Returns desktop value for width >= 900
  T responsiveValue<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // ============================================================================
  // Theme Extensions
  // ============================================================================

  /// Get theme data
  ThemeData get theme => Theme.of(this);

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get primary color
  Color get primaryColor => colorScheme.primary;

  /// Get secondary color
  Color get secondaryColor => colorScheme.secondary;

  /// Get background color (uses surface in Material 3)
  Color get backgroundColor => colorScheme.surface;

  /// Get surface color
  Color get surfaceColor => colorScheme.surface;

  /// Get error color
  Color get errorColor => colorScheme.error;

  /// Get scaffold background color
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  /// Get card color
  Color get cardColor => theme.cardColor;

  /// Get divider color
  Color get dividerColor => theme.dividerColor;

  /// Get icon theme
  IconThemeData get iconTheme => theme.iconTheme;

  /// Get app bar theme
  AppBarThemeData get appBarTheme => theme.appBarTheme;

  // ============================================================================
  // TextStyle Extensions (Display)
  // ============================================================================

  /// Get display large text style
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Get display medium text style
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Get display small text style
  TextStyle? get displaySmall => textTheme.displaySmall;

  // ============================================================================
  // TextStyle Extensions (Headline)
  // ============================================================================

  /// Get headline large text style
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Get headline medium text style
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Get headline small text style
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  // ============================================================================
  // TextStyle Extensions (Title)
  // ============================================================================

  /// Get title large text style
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Get title medium text style
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Get title small text style
  TextStyle? get titleSmall => textTheme.titleSmall;

  // ============================================================================
  // TextStyle Extensions (Body)
  // ============================================================================

  /// Get body large text style
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Get body medium text style
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Get body small text style
  TextStyle? get bodySmall => textTheme.bodySmall;

  // ============================================================================
  // TextStyle Extensions (Label)
  // ============================================================================

  /// Get label large text style
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Get label medium text style
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Get label small text style
  TextStyle? get labelSmall => textTheme.labelSmall;

  // ============================================================================
  // Focus Extensions
  // ============================================================================

  /// Get focus scope
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Unfocus current focus node (dismiss keyboard)
  void unfocus() => focusScope.unfocus();

  /// Request focus for a node
  void requestFocus([FocusNode? node]) {
    if (node != null) {
      focusScope.requestFocus(node);
    } else {
      focusScope.requestFocus();
    }
  }

  // ============================================================================
  // Dialog & BottomSheet Helpers
  // ============================================================================

  /// Show material dialog
  Future<T?> showMaterialDialog<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
  }) {
    return showDialog<T>(
      context: this,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
    );
  }

  /// Show bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    bool enableDrag = true,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
    );
  }

  /// Show snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    SnackBarBehavior? behavior,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        behavior: behavior,
      ),
    );
  }
}
