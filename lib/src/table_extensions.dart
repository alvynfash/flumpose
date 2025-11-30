import 'package:flutter/material.dart';

/// Table and grid layout extensions
extension TableExtensions on List<List<Widget>> {
  /// Convert 2D list to Table widget
  /// Performance: Single Table widget for tabular layouts
  Widget toTable({
    Map<int, TableColumnWidth>? columnWidths,
    TableColumnWidth defaultColumnWidth = const FlexColumnWidth(),
    TextDirection? textDirection,
    TableBorder? border,
    TableCellVerticalAlignment defaultVerticalAlignment =
        TableCellVerticalAlignment.top,
  }) {
    return Table(
      columnWidths: columnWidths,
      defaultColumnWidth: defaultColumnWidth,
      textDirection: textDirection,
      border: border,
      defaultVerticalAlignment: defaultVerticalAlignment,
      children: map((row) => TableRow(children: row)).toList(),
    );
  }

  /// Convert 2D list to Table with borders
  /// Performance: Optimized for common bordered table pattern
  Widget toBorderedTable({
    Color borderColor = Colors.grey,
    double borderWidth = 1.0,
    TableColumnWidth defaultColumnWidth = const FlexColumnWidth(),
  }) {
    return Table(
      border: TableBorder.all(color: borderColor, width: borderWidth),
      defaultColumnWidth: defaultColumnWidth,
      children: map((row) => TableRow(children: row)).toList(),
    );
  }
}

/// ListTile extensions for common list patterns
extension ListTileExtensions on Widget {
  /// Wrap in ListTile
  /// Performance: Single ListTile wrapper
  Widget listTile({
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    bool isThreeLine = false,
    bool? dense,
    EdgeInsetsGeometry? contentPadding,
    bool enabled = true,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    bool selected = false,
  }) {
    return ListTile(
      leading: leading,
      title: title ?? this,
      subtitle: subtitle,
      trailing: trailing,
      isThreeLine: isThreeLine,
      dense: dense,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: onTap,
      onLongPress: onLongPress,
      selected: selected,
    );
  }

  /// Wrap in Divider-separated list
  /// Performance: Lightweight divider insertion
  Widget withDivider({
    double? height,
    double? thickness,
    Color? color,
    double? indent,
    double? endIndent,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        this,
        Divider(
          height: height,
          thickness: thickness,
          color: color,
          indent: indent,
          endIndent: endIndent,
        ),
      ],
    );
  }
}

/// List divider extensions
extension ListDividerExtensions on List<Widget> {
  /// Insert dividers between list items
  /// Performance: Only creates dividers between items (n-1 dividers for n items)
  List<Widget> withDividers({
    double? height,
    double? thickness,
    Color? color,
    double? indent,
    double? endIndent,
  }) {
    if (isEmpty) return this;

    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(
          Divider(
            height: height,
            thickness: thickness,
            color: color,
            indent: indent,
            endIndent: endIndent,
          ),
        );
      }
    }
    return result;
  }

  /// Insert custom separator between list items
  /// Performance: Only creates separators between items
  List<Widget> separated(Widget separator) {
    if (isEmpty) return this;

    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}
