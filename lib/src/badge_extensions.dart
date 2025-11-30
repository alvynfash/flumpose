import 'package:flutter/material.dart';

/// Badge extensions for adding badges to widgets
extension BadgeExtensions on Widget {
  /// Add a badge with optional count
  /// Performance: Lightweight Stack + Positioned wrapper
  Widget badge({
    String? label,
    int? count,
    Color? backgroundColor,
    Color? textColor,
    double? size,
    Alignment alignment = Alignment.topRight,
    EdgeInsets? offset,
    bool showZero = false,
  }) {
    // Don't show badge if count is 0 and showZero is false
    if (count != null && count == 0 && !showZero) {
      return this;
    }

    final badgeText = label ?? (count != null ? count.toString() : '');
    final shouldShowText = badgeText.isNotEmpty;
    final badgeSize = size ?? (shouldShowText ? 20.0 : 12.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        this,
        Positioned(
          top: alignment == Alignment.topRight || alignment == Alignment.topLeft
              ? (offset?.top ?? -4)
              : null,
          bottom:
              alignment == Alignment.bottomRight ||
                  alignment == Alignment.bottomLeft
              ? (offset?.bottom ?? -4)
              : null,
          right:
              alignment == Alignment.topRight ||
                  alignment == Alignment.bottomRight
              ? (offset?.right ?? -4)
              : null,
          left:
              alignment == Alignment.topLeft ||
                  alignment == Alignment.bottomLeft
              ? (offset?.left ?? -4)
              : null,
          child: Container(
            constraints: BoxConstraints(
              minWidth: badgeSize,
              minHeight: badgeSize,
            ),
            padding: shouldShowText
                ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                : null,
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.red,
              borderRadius: BorderRadius.circular(badgeSize / 2),
            ),
            child: shouldShowText
                ? Center(
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  /// Add a simple dot badge (no text)
  /// Performance: Minimal Stack + Positioned + Container
  Widget dotBadge({
    Color? color,
    double size = 8,
    Alignment alignment = Alignment.topRight,
    EdgeInsets? offset,
  }) {
    return badge(
      backgroundColor: color,
      size: size,
      alignment: alignment,
      offset: offset,
    );
  }

  /// Add a notification badge with count
  /// Performance: Optimized for common notification pattern
  Widget notificationBadge(int count, {bool showZero = false}) {
    return badge(
      count: count,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      showZero: showZero,
    );
  }
}
