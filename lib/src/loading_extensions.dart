import 'package:flutter/material.dart';

/// Loading state extensions for shimmer and skeleton effects
extension LoadingExtensions on Widget {
  /// Apply shimmer loading effect
  /// Performance: Uses AnimatedContainer for smooth animations
  Widget shimmer({
    Color baseColor = const Color(0xFFE0E0E0),
    Color highlightColor = const Color(0xFFF5F5F5),
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return _ShimmerWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      duration: duration,
      child: this,
    );
  }

  /// Apply skeleton loading effect (simplified shimmer)
  /// Performance: Lightweight wrapper with simple color overlay
  Widget skeleton({
    Color color = const Color(0xFFE0E0E0),
    BorderRadius? borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
      child: Opacity(opacity: 0.0, child: this),
    );
  }
}

/// Internal shimmer widget implementation
/// Performance: Uses single AnimatedBuilder with gradient shader
class _ShimmerWidget extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const _ShimmerWidget({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
  });

  @override
  State<_ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<_ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
