import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Extensions for platform-adaptive widget behavior
extension PlatformAdaptiveExtensions on Widget {
  /// Apply platform-specific transformations to the widget
  Widget platformAdaptive({
    Widget Function(Widget)? ios,
    Widget Function(Widget)? android,
    Widget Function(Widget)? web,
    Widget Function(Widget)? macos,
    Widget Function(Widget)? windows,
    Widget Function(Widget)? linux,
    Widget Function(Widget)? fuchsia,
    Widget Function(Widget)? fallback,
  }) {
    return _PlatformAdaptiveWrapper(
      ios: ios,
      android: android,
      web: web,
      macos: macos,
      windows: windows,
      linux: linux,
      fuchsia: fuchsia,
      fallback: fallback,
      child: this,
    );
  }

  /// Show widget only on iOS
  Widget onlyIOS() =>
      platformAdaptive(ios: (w) => w, fallback: (w) => const SizedBox.shrink());

  /// Show widget only on Android
  Widget onlyAndroid() => platformAdaptive(
    android: (w) => w,
    fallback: (w) => const SizedBox.shrink(),
  );

  /// Show widget only on Web
  Widget onlyWeb() =>
      platformAdaptive(web: (w) => w, fallback: (w) => const SizedBox.shrink());

  /// Show widget only on macOS
  Widget onlyMacOS() => platformAdaptive(
    macos: (w) => w,
    fallback: (w) => const SizedBox.shrink(),
  );

  /// Show widget only on Windows
  Widget onlyWindows() => platformAdaptive(
    windows: (w) => w,
    fallback: (w) => const SizedBox.shrink(),
  );

  /// Show widget only on Linux
  Widget onlyLinux() => platformAdaptive(
    linux: (w) => w,
    fallback: (w) => const SizedBox.shrink(),
  );

  /// Show widget only on mobile platforms (iOS and Android)
  Widget onlyMobilePlatform() => platformAdaptive(
    ios: (w) => w,
    android: (w) => w,
    fallback: (w) => const SizedBox.shrink(),
  );

  /// Show widget only on desktop platforms (macOS, Windows, Linux)
  Widget onlyDesktopPlatform() => platformAdaptive(
    macos: (w) => w,
    windows: (w) => w,
    linux: (w) => w,
    fallback: (w) => const SizedBox.shrink(),
  );
}

class _PlatformAdaptiveWrapper extends StatelessWidget {
  const _PlatformAdaptiveWrapper({
    required this.child,
    this.ios,
    this.android,
    this.web,
    this.macos,
    this.windows,
    this.linux,
    this.fuchsia,
    this.fallback,
  });

  final Widget child;
  final Widget Function(Widget)? ios;
  final Widget Function(Widget)? android;
  final Widget Function(Widget)? web;
  final Widget Function(Widget)? macos;
  final Widget Function(Widget)? windows;
  final Widget Function(Widget)? linux;
  final Widget Function(Widget)? fuchsia;
  final Widget Function(Widget)? fallback;

  @override
  Widget build(BuildContext context) {
    Widget Function(Widget)? transformer;

    if (kIsWeb) {
      transformer = web;
    } else {
      switch (Platform.operatingSystem) {
        case 'ios':
          transformer = ios;
          break;
        case 'android':
          transformer = android;
          break;
        case 'macos':
          transformer = macos;
          break;
        case 'windows':
          transformer = windows;
          break;
        case 'linux':
          transformer = linux;
          break;
        case 'fuchsia':
          transformer = fuchsia;
          break;
      }
    }

    transformer ??= fallback;

    return transformer?.call(child) ?? child;
  }
}
