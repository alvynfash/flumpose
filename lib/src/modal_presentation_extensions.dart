import 'package:flutter/material.dart';

/// Extensions for modal presentations
extension ModalPresentationExtensions on Widget {
  /// Show widget as a bottom sheet
  Future<T?> showAsBottomSheet<T>(
    BuildContext context, {
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => this,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
    );
  }

  /// Show widget as a dialog
  Future<T?> showAsDialog<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  /// Show widget as a snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showAsSnackBar(
    BuildContext context, {
    Duration? duration,
    SnackBarAction? action,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
    Color? backgroundColor,
    Animation<double>? animation,
    VoidCallback? onVisible,
    DismissDirection dismissDirection = DismissDirection.down,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    final snackBar = SnackBar(
      content: this,
      duration: duration ?? const Duration(seconds: 4),
      action: action,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      hitTestBehavior: hitTestBehavior,
      behavior: behavior,
      backgroundColor: backgroundColor,
      animation: animation,
      onVisible: onVisible,
      dismissDirection: dismissDirection,
      clipBehavior: clipBehavior,
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show widget as a popup menu
  Future<T?> showAsPopup<T>(
    BuildContext context, {
    RelativeRect? position,
    List<PopupMenuEntry<T>>? items,
    T? initialValue,
    double? elevation,
    String? semanticLabel,
    ShapeBorder? shape,
    Color? color,
    bool useRootNavigator = false,
  }) {
    return showMenu<T>(
      context: context,
      position: position ?? RelativeRect.fill,
      items: items ?? [],
      initialValue: initialValue,
      elevation: elevation,
      semanticLabel: semanticLabel,
      shape: shape,
      color: color,
      useRootNavigator: useRootNavigator,
    );
  }

  /// Show widget as a full-screen dialog
  Future<T?> showAsFullScreenDialog<T>(BuildContext context) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: (context) => this, fullscreenDialog: true),
    );
  }

  /// Show widget as a custom dialog with custom positioning
  Future<T?> showAsCustomDialog<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(alignment: alignment, child: this);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
    );
  }

  /// Show widget as a draggable scrollable sheet
  Future<T?> showAsDraggableSheet<T>(
    BuildContext context, {
    double initialChildSize = 0.5,
    double minChildSize = 0.25,
    double maxChildSize = 1.0,
    bool expand = true,
    bool snap = false,
    List<double>? snapSizes,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        expand: expand,
        snap: snap,
        snapSizes: snapSizes,
        builder: (context, scrollController) => this,
      ),
    );
  }
}

/// Extension for quick toast-like messages
extension ToastExtensions on String {
  /// Show string as a toast message
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showAsToast(
    BuildContext context, {
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
    double? elevation,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
  }) {
    return Text(this, style: TextStyle(color: textColor)).showAsSnackBar(
      context,
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
    );
  }

  /// Show string as a quick snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showAsSnackBar(
    BuildContext context, {
    Duration? duration,
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
    double? elevation,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
  }) {
    return Text(this, style: TextStyle(color: textColor)).showAsSnackBar(
      context,
      duration: duration,
      action: action,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      behavior: behavior,
    );
  }
}
