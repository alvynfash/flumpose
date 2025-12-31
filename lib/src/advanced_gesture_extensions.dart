import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Data class for swipe details
class SwipeDetails {
  const SwipeDetails({
    required this.direction,
    required this.velocity,
    required this.distance,
  });

  final SwipeDirection direction;
  final Velocity velocity;
  final double distance;
}

/// Enum for swipe directions
enum SwipeDirection { left, right, up, down }

/// Data classes for performance testing
class MemoryUsage {
  const MemoryUsage({
    required this.current,
    required this.peak,
    required this.timestamp,
  });

  final double current;
  final double peak;
  final DateTime timestamp;
}

class StressTestResult {
  const StressTestResult({
    required this.averageFPS,
    required this.minFPS,
    required this.maxFPS,
    required this.totalFrames,
    required this.droppedFrames,
  });

  final double averageFPS;
  final double minFPS;
  final double maxFPS;
  final int totalFrames;
  final int droppedFrames;
}

class BenchmarkResult {
  const BenchmarkResult({
    required this.testName,
    required this.averageBuildTime,
    required this.minBuildTime,
    required this.maxBuildTime,
    required this.totalRuns,
  });

  final String testName;
  final Duration averageBuildTime;
  final Duration minBuildTime;
  final Duration maxBuildTime;
  final int totalRuns;
}

/// Extensions for advanced gesture detection
extension SwipeGestureExtensions on Widget {
  /// Detect swipe gestures in all directions
  Widget onSwipe({
    VoidCallback? onSwipeLeft,
    VoidCallback? onSwipeRight,
    VoidCallback? onSwipeUp,
    VoidCallback? onSwipeDown,
    double sensitivity = 50.0,
    Duration? debounce,
  }) {
    return _SwipeDetector(
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      onSwipeUp: onSwipeUp,
      onSwipeDown: onSwipeDown,
      sensitivity: sensitivity,
      debounce: debounce,
      child: this,
    );
  }

  /// Detect horizontal swipe gestures only
  Widget onSwipeHorizontal({
    VoidCallback? onSwipeLeft,
    VoidCallback? onSwipeRight,
    double sensitivity = 50.0,
  }) {
    return onSwipe(
      onSwipeLeft: onSwipeLeft,
      onSwipeRight: onSwipeRight,
      sensitivity: sensitivity,
    );
  }

  /// Detect vertical swipe gestures only
  Widget onSwipeVertical({
    VoidCallback? onSwipeUp,
    VoidCallback? onSwipeDown,
    double sensitivity = 50.0,
  }) {
    return onSwipe(
      onSwipeUp: onSwipeUp,
      onSwipeDown: onSwipeDown,
      sensitivity: sensitivity,
    );
  }

  /// Detect swipe gestures with detailed information
  Widget onSwipeWithDetails({
    void Function(SwipeDetails)? onSwipe,
    double sensitivity = 50.0,
  }) {
    return _SwipeDetectorWithDetails(
      onSwipe: onSwipe,
      sensitivity: sensitivity,
      child: this,
    );
  }

  /// Detect multi-touch gestures
  Widget onMultiTouch({
    VoidCallback? onTwoFingerTap,
    VoidCallback? onThreeFingerTap,
    VoidCallback? onFourFingerTap,
    void Function(int)? onMultiFingerTap,
    void Function(ScaleStartDetails)? onPinchStart,
    void Function(ScaleUpdateDetails)? onPinchUpdate,
    void Function(ScaleEndDetails)? onPinchEnd,
    Duration tapTimeout = const Duration(milliseconds: 300),
  }) {
    return _MultiTouchDetector(
      onTwoFingerTap: onTwoFingerTap,
      onThreeFingerTap: onThreeFingerTap,
      onFourFingerTap: onFourFingerTap,
      onMultiFingerTap: onMultiFingerTap,
      onPinchStart: onPinchStart,
      onPinchUpdate: onPinchUpdate,
      onPinchEnd: onPinchEnd,
      tapTimeout: tapTimeout,
      child: this,
    );
  }

  /// Detect pinch-to-zoom gestures with constraints
  Widget onPinchZoom({
    void Function(double scale)? onZoom,
    void Function()? onZoomStart,
    void Function()? onZoomEnd,
    double minScale = 0.5,
    double maxScale = 3.0,
  }) {
    return _PinchZoomDetector(
      onZoom: onZoom,
      onZoomStart: onZoomStart,
      onZoomEnd: onZoomEnd,
      minScale: minScale,
      maxScale: maxScale,
      child: this,
    );
  }

  /// Detect rotation gestures
  Widget onRotateGesture({
    void Function(double angle)? onRotate,
    void Function()? onRotateStart,
    void Function()? onRotateEnd,
    double sensitivity = 1.0,
  }) {
    return _RotateGestureDetector(
      onRotate: onRotate,
      onRotateStart: onRotateStart,
      onRotateEnd: onRotateEnd,
      sensitivity: sensitivity,
      child: this,
    );
  }
}

class _SwipeDetector extends StatefulWidget {
  const _SwipeDetector({
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    required this.sensitivity,
    this.debounce,
  });

  final Widget child;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final double sensitivity;
  final Duration? debounce;

  @override
  State<_SwipeDetector> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<_SwipeDetector> {
  DateTime? _lastSwipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        final now = DateTime.now();
        if (widget.debounce != null &&
            _lastSwipe != null &&
            now.difference(_lastSwipe!) < widget.debounce!) {
          return;
        }

        final velocity = details.velocity.pixelsPerSecond;
        final dx = velocity.dx.abs();
        final dy = velocity.dy.abs();

        if (dx > widget.sensitivity || dy > widget.sensitivity) {
          _lastSwipe = now;

          if (dx > dy) {
            // Horizontal swipe
            if (velocity.dx > 0) {
              widget.onSwipeRight?.call();
            } else {
              widget.onSwipeLeft?.call();
            }
          } else {
            // Vertical swipe
            if (velocity.dy > 0) {
              widget.onSwipeDown?.call();
            } else {
              widget.onSwipeUp?.call();
            }
          }
        }
      },
      child: widget.child,
    );
  }
}

class _SwipeDetectorWithDetails extends StatelessWidget {
  const _SwipeDetectorWithDetails({
    required this.child,
    this.onSwipe,
    required this.sensitivity,
  });

  final Widget child;
  final void Function(SwipeDetails)? onSwipe;
  final double sensitivity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond;
        final dx = velocity.dx.abs();
        final dy = velocity.dy.abs();
        final distance = math.sqrt(dx * dx + dy * dy);

        if (distance > sensitivity) {
          SwipeDirection direction;
          if (dx > dy) {
            direction = velocity.dx > 0
                ? SwipeDirection.right
                : SwipeDirection.left;
          } else {
            direction = velocity.dy > 0
                ? SwipeDirection.down
                : SwipeDirection.up;
          }

          onSwipe?.call(
            SwipeDetails(
              direction: direction,
              velocity: details.velocity,
              distance: distance,
            ),
          );
        }
      },
      child: child,
    );
  }
}

class _MultiTouchDetector extends StatefulWidget {
  const _MultiTouchDetector({
    required this.child,
    this.onTwoFingerTap,
    this.onThreeFingerTap,
    this.onFourFingerTap,
    this.onMultiFingerTap,
    this.onPinchStart,
    this.onPinchUpdate,
    this.onPinchEnd,
    required this.tapTimeout,
  });

  final Widget child;
  final VoidCallback? onTwoFingerTap;
  final VoidCallback? onThreeFingerTap;
  final VoidCallback? onFourFingerTap;
  final void Function(int)? onMultiFingerTap;
  final void Function(ScaleStartDetails)? onPinchStart;
  final void Function(ScaleUpdateDetails)? onPinchUpdate;
  final void Function(ScaleEndDetails)? onPinchEnd;
  final Duration tapTimeout;

  @override
  State<_MultiTouchDetector> createState() => _MultiTouchDetectorState();
}

class _MultiTouchDetectorState extends State<_MultiTouchDetector> {
  int _pointerCount = 0;
  DateTime? _tapStart;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _pointerCount++;
        _tapStart = DateTime.now();
      },
      onPointerUp: (event) {
        _pointerCount--;
        if (_pointerCount == 0 && _tapStart != null) {
          final tapDuration = DateTime.now().difference(_tapStart!);
          if (tapDuration <= widget.tapTimeout) {
            final fingerCount = event.pointer + 1;
            _handleMultiFingerTap(fingerCount);
          }
        }
      },
      child: GestureDetector(
        onScaleStart: widget.onPinchStart,
        onScaleUpdate: widget.onPinchUpdate,
        onScaleEnd: widget.onPinchEnd,
        child: widget.child,
      ),
    );
  }

  void _handleMultiFingerTap(int fingerCount) {
    widget.onMultiFingerTap?.call(fingerCount);

    switch (fingerCount) {
      case 2:
        widget.onTwoFingerTap?.call();
        break;
      case 3:
        widget.onThreeFingerTap?.call();
        break;
      case 4:
        widget.onFourFingerTap?.call();
        break;
    }
  }
}

class _PinchZoomDetector extends StatefulWidget {
  const _PinchZoomDetector({
    required this.child,
    this.onZoom,
    this.onZoomStart,
    this.onZoomEnd,
    required this.minScale,
    required this.maxScale,
  });

  final Widget child;
  final void Function(double scale)? onZoom;
  final void Function()? onZoomStart;
  final void Function()? onZoomEnd;
  final double minScale;
  final double maxScale;

  @override
  State<_PinchZoomDetector> createState() => _PinchZoomDetectorState();
}

class _PinchZoomDetectorState extends State<_PinchZoomDetector> {
  final double _currentScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        widget.onZoomStart?.call();
      },
      onScaleUpdate: (details) {
        final newScale = (_currentScale * details.scale).clamp(
          widget.minScale,
          widget.maxScale,
        );
        widget.onZoom?.call(newScale);
      },
      onScaleEnd: (details) {
        widget.onZoomEnd?.call();
      },
      child: widget.child,
    );
  }
}

class _RotateGestureDetector extends StatefulWidget {
  const _RotateGestureDetector({
    required this.child,
    this.onRotate,
    this.onRotateStart,
    this.onRotateEnd,
    required this.sensitivity,
  });

  final Widget child;
  final void Function(double angle)? onRotate;
  final void Function()? onRotateStart;
  final void Function()? onRotateEnd;
  final double sensitivity;

  @override
  State<_RotateGestureDetector> createState() => _RotateGestureDetectorState();
}

class _RotateGestureDetectorState extends State<_RotateGestureDetector> {
  double _currentRotation = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        widget.onRotateStart?.call();
      },
      onScaleUpdate: (details) {
        final rotation = details.rotation * widget.sensitivity;
        _currentRotation += rotation;
        widget.onRotate?.call(_currentRotation);
      },
      onScaleEnd: (details) {
        widget.onRotateEnd?.call();
      },
      child: widget.child,
    );
  }
}
