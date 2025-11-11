import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

/// Animation configuration that can be inherited by child widgets
class AnimationConfig {
  final Duration duration;
  final Curve curve;

  const AnimationConfig({required this.duration, required this.curve});

  static const defaultConfig = AnimationConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimationConfig &&
          duration == other.duration &&
          curve == other.curve;

  @override
  int get hashCode => Object.hash(duration, curve);
}

/// Internal widget that provides animation configuration to descendants
class _AnimationConfigProvider extends InheritedWidget {
  final AnimationConfig config;

  const _AnimationConfigProvider({required this.config, required super.child});

  static AnimationConfig? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AnimationConfigProvider>()
        ?.config;
  }

  @override
  bool updateShouldNotify(_AnimationConfigProvider oldWidget) =>
      config != oldWidget.config;
}

/// Efficient wrapper that provides animation config to a single animated widget
/// Avoids repeated Builder allocations by caching the lookup
///
/// This is internal but needs to be public for use across extension files
class AnimatedWrapper extends StatelessWidget {
  final Widget Function(AnimationConfig config) builder;

  const AnimatedWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final config =
        _AnimationConfigProvider.maybeOf(context) ??
        AnimationConfig.defaultConfig;
    return builder(config);
  }
}

/// Extension to configure animations for descendant widgets
extension AnimationExtensions on Widget {
  /// Configure animation parameters for all descendant widgets that support animation.
  /// Place this AFTER the widgets you want to animate.
  ///
  /// Example:
  /// ```dart
  /// Container()
  ///   .pad(isExpanded ? 20 : 10, animate: true)
  ///   .animate(
  ///     duration: Duration(milliseconds: 300),
  ///     curve: Curves.easeOut,
  ///   )
  /// ```
  Widget animate({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return _AnimationConfigProvider(
      config: AnimationConfig(duration: duration, curve: curve),
      child: this,
    );
  }

  /// Simple fade animation
  Widget fade({Duration duration = const Duration(milliseconds: 300)}) =>
      AnimatedOpacity(opacity: 1.0, duration: duration, child: this);
}

/// Animated Text widget that supports style animations
/// More efficient than wrapping Text in AnimatedDefaultTextStyle
class AnimatedText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const AnimatedText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final config =
        _AnimationConfigProvider.maybeOf(context) ??
        AnimationConfig.defaultConfig;

    return AnimatedDefaultTextStyle(
      style: style ?? const TextStyle(),
      duration: config.duration,
      curve: config.curve,
      child: Text(
        data,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}

/// Animated Icon widget that supports color and size animations
class AnimatedIconWidget extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const AnimatedIconWidget(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    final config =
        _AnimationConfigProvider.maybeOf(context) ??
        AnimationConfig.defaultConfig;

    // Use TweenAnimationBuilder for more efficient icon animations
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: color),
      duration: config.duration,
      curve: config.curve,
      builder: (context, animatedColor, _) {
        return Icon(
          icon,
          size: size,
          color: animatedColor,
          semanticLabel: semanticLabel,
          textDirection: textDirection,
        );
      },
    );
  }
}
