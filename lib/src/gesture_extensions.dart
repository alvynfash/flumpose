import 'package:flutter/material.dart';

extension TapExtensions on Widget {
  Widget onTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);
  Widget onDoubleTap(VoidCallback onDoubleTap) =>
      GestureDetector(onDoubleTap: onDoubleTap, child: this);
  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);
}

extension RippleExtension on Widget {
  Widget ripple(VoidCallback? onTap, {BorderRadius? borderRadius}) => Material(
    color: Colors.transparent,
    child: InkWell(borderRadius: borderRadius, onTap: onTap, child: this),
  );
}

extension GesturesExtension on Widget {
  Widget gestures({
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
  }) => GestureDetector(onTap: onTap, onLongPress: onLongPress, child: this);
}

/// Advanced gesture extensions for pan, drag, and scale
extension AdvancedGestureExtensions on Widget {
  /// Adds pan gesture detection
  Widget onPan({
    GestureDragStartCallback? onPanStart,
    GestureDragUpdateCallback? onPanUpdate,
    GestureDragEndCallback? onPanEnd,
    GestureDragCancelCallback? onPanCancel,
  }) => GestureDetector(
    onPanStart: onPanStart,
    onPanUpdate: onPanUpdate,
    onPanEnd: onPanEnd,
    onPanCancel: onPanCancel,
    child: this,
  );

  /// Adds horizontal drag gesture detection
  Widget onHorizontalDrag({
    GestureDragStartCallback? onStart,
    GestureDragUpdateCallback? onUpdate,
    GestureDragEndCallback? onEnd,
  }) => GestureDetector(
    onHorizontalDragStart: onStart,
    onHorizontalDragUpdate: onUpdate,
    onHorizontalDragEnd: onEnd,
    child: this,
  );

  /// Adds vertical drag gesture detection
  Widget onVerticalDrag({
    GestureDragStartCallback? onStart,
    GestureDragUpdateCallback? onUpdate,
    GestureDragEndCallback? onEnd,
  }) => GestureDetector(
    onVerticalDragStart: onStart,
    onVerticalDragUpdate: onUpdate,
    onVerticalDragEnd: onEnd,
    child: this,
  );

  /// Adds scale gesture detection (pinch to zoom)
  Widget onScale({
    GestureScaleStartCallback? onScaleStart,
    GestureScaleUpdateCallback? onScaleUpdate,
    GestureScaleEndCallback? onScaleEnd,
  }) => GestureDetector(
    onScaleStart: onScaleStart,
    onScaleUpdate: onScaleUpdate,
    onScaleEnd: onScaleEnd,
    child: this,
  );

  /// Makes widget draggable
  Widget draggable<T extends Object>({
    required T data,
    Widget? feedback,
    Widget? childWhenDragging,
    Axis? axis,
    Offset? dragAnchorStrategy,
    VoidCallback? onDragStarted,
    DraggableCanceledCallback? onDraggableCanceled,
    DragEndCallback? onDragEnd,
  }) => Draggable<T>(
    data: data,
    feedback: feedback ?? this,
    childWhenDragging: childWhenDragging,
    axis: axis,
    onDragStarted: onDragStarted,
    onDraggableCanceled: onDraggableCanceled,
    onDragEnd: onDragEnd,
    child: this,
  );

  /// Makes widget a drag target
  Widget dragTarget<T extends Object>({
    required DragTargetBuilder<T> builder,
    DragTargetWillAcceptWithDetails<T>? onWillAcceptWithDetails,
    DragTargetAccept<T>? onAccept,
    DragTargetAcceptWithDetails<T>? onAcceptWithDetails,
    DragTargetLeave<T>? onLeave,
  }) => DragTarget<T>(
    builder: builder,
    onWillAcceptWithDetails: onWillAcceptWithDetails,
    onAcceptWithDetails: onAcceptWithDetails,
    // onAcceptWithDetails: onAcceptWithDetails,
    onLeave: onLeave,
  );

  /// Adds long press with duration control
  Widget onLongPressWithDuration({
    required GestureLongPressCallback onLongPress,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate,
    GestureLongPressUpCallback? onLongPressUp,
    GestureLongPressEndCallback? onLongPressEnd,
  }) => GestureDetector(
    onLongPress: onLongPress,
    onLongPressStart: onLongPressStart,
    onLongPressMoveUpdate: onLongPressMoveUpdate,
    onLongPressUp: onLongPressUp,
    onLongPressEnd: onLongPressEnd,
    child: this,
  );

  /// Adds tap with position details
  Widget onTapWithPosition({
    required Function(TapDownDetails) onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCallback? onTap,
  }) => GestureDetector(
    onTapDown: onTapDown,
    onTapUp: onTapUp,
    onTap: onTap,
    child: this,
  );
}
