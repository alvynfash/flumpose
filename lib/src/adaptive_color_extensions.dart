import 'package:flutter/material.dart';
import 'background_extensions.dart';

/// Extensions for adaptive color management based on theme and brightness
extension AdaptiveColorExtensions on Widget {
  /// Apply adaptive colors based on brightness and accessibility settings
  Widget adaptiveColor({
    Color? light,
    Color? dark,
    Color? highContrast,
    Color? fallback,
  }) {
    return _AdaptiveColorWrapper(
      light: light,
      dark: dark,
      highContrast: highContrast,
      fallback: fallback,
      child: this,
    );
  }

  /// Apply adaptive background color based on brightness
  Widget adaptiveBackgroundColor({
    Color? light,
    Color? dark,
    Color? highContrast,
  }) {
    return Builder(
      builder: (context) {
        final brightness = Theme.of(context).brightness;
        final isHighContrast = MediaQuery.of(context).highContrast;

        Color? color;
        if (isHighContrast && highContrast != null) {
          color = highContrast;
        } else if (brightness == Brightness.dark && dark != null) {
          color = dark;
        } else if (light != null) {
          color = light;
        }

        return color != null ? backgroundColor(color) : this;
      },
    );
  }

  /// Apply theme's primary color as background
  Widget primaryColor() => Builder(
    builder: (context) => backgroundColor(Theme.of(context).primaryColor),
  );

  /// Apply theme's surface color as background
  Widget surfaceColor() => Builder(
    builder: (context) =>
        backgroundColor(Theme.of(context).colorScheme.surface),
  );

  /// Apply theme's onSurface color as background
  Widget onSurfaceColor() => Builder(
    builder: (context) =>
        backgroundColor(Theme.of(context).colorScheme.onSurface),
  );

  /// Apply theme's secondary color as background
  Widget secondaryColor() => Builder(
    builder: (context) =>
        backgroundColor(Theme.of(context).colorScheme.secondary),
  );

  /// Apply theme's error color as background
  Widget errorColor() => Builder(
    builder: (context) => backgroundColor(Theme.of(context).colorScheme.error),
  );

  /// Apply theme's background color as background
  Widget themeBackgroundColor() => Builder(
    builder: (context) =>
        backgroundColor(Theme.of(context).colorScheme.surface),
  );
}

class _AdaptiveColorWrapper extends StatelessWidget {
  const _AdaptiveColorWrapper({
    required this.child,
    this.light,
    this.dark,
    this.highContrast,
    this.fallback,
  });

  final Widget child;
  final Color? light;
  final Color? dark;
  final Color? highContrast;
  final Color? fallback;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isHighContrast = MediaQuery.of(context).highContrast;

    Color? color;
    if (isHighContrast && highContrast != null) {
      color = highContrast;
    } else if (brightness == Brightness.dark && dark != null) {
      color = dark;
    } else if (light != null) {
      color = light;
    }

    color ??= fallback;

    if (color != null) {
      return DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(color: color),
        child: child,
      );
    }

    return child;
  }
}
