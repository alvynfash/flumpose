import 'package:flutter/material.dart';

/// Conditional and state-based widget extensions
extension ConditionalExtensions on Widget {
  /// Apply a transformation conditionally
  /// Performance: Zero overhead when condition is false
  Widget when(bool condition, Widget Function(Widget) transform) {
    return condition ? transform(this) : this;
  }

  /// Apply different transformations based on condition
  /// Performance: Only builds the active branch
  Widget conditional(
    bool condition, {
    required Widget Function(Widget) onTrue,
    Widget Function(Widget)? onFalse,
  }) {
    return condition ? onTrue(this) : (onFalse?.call(this) ?? this);
  }

  /// Show different widgets based on loading state
  /// Performance: Only builds the active state widget
  Widget loadingState({required bool isLoading, Widget? loadingWidget}) {
    if (isLoading) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }
    return this;
  }

  /// Show widget or error based on condition
  /// Performance: Only builds the active state
  Widget errorState({
    required bool hasError,
    Widget? errorWidget,
    String? errorMessage,
  }) {
    if (hasError) {
      return errorWidget ??
          Center(
            child: Text(
              errorMessage ?? 'An error occurred',
              style: const TextStyle(color: Colors.red),
            ),
          );
    }
    return this;
  }

  /// Show widget or empty state based on condition
  /// Performance: Only builds the active state
  Widget emptyState({
    required bool isEmpty,
    Widget? emptyWidget,
    String? emptyMessage,
  }) {
    if (isEmpty) {
      return emptyWidget ??
          Center(
            child: Text(
              emptyMessage ?? 'No data available',
              style: const TextStyle(color: Colors.grey),
            ),
          );
    }
    return this;
  }

  /// Switch between multiple states
  /// Performance: Only builds the selected state
  Widget switchState<T>({
    required T state,
    required Map<T, Widget Function(Widget)> cases,
    Widget Function(Widget)? defaultCase,
  }) {
    final transform = cases[state] ?? defaultCase;
    return transform?.call(this) ?? this;
  }
}
