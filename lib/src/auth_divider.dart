import 'package:flutter/material.dart';

/// A horizontal divider with optional text for authentication screens.
///
/// This widget creates a divider with text in the middle, commonly used
/// in authentication flows to separate different sections or indicate "OR".
///
/// ## Features:
/// - **Customizable text**: Display any text in the center
/// - **Flexible styling**: Custom colors, spacing, and padding
/// - **Responsive design**: Adapts to different screen sizes
/// - **Accessibility ready**: Proper semantic structure
///
/// ## Usage Example:
/// ```dart
/// AuthDivider(
///   text: 'OR',
///   textStyle: TextStyle(color: Colors.grey),
///   dividerColor: Colors.grey.shade300,
///   spacing: 16.0,
/// )
/// ```
class AuthDivider extends StatelessWidget {
  /// Creates an [AuthDivider].
  ///
  /// The [text] parameter is required and will be displayed between the dividers.
  const AuthDivider({
    super.key,
    required this.text,
    this.textStyle,
    this.dividerColor,
    this.spacing = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  /// Text displayed in the center of the divider.
  final String text;

  /// Style for the text. If null, uses default text style.
  final TextStyle? textStyle;

  /// Color of the divider lines. If null, uses theme divider color.
  final Color? dividerColor;

  /// Spacing between the text and divider lines.
  final double spacing;

  /// Padding around the entire widget.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final defaultDividerColor = theme.colorScheme.outline;

    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: dividerColor ?? defaultDividerColor,
              thickness: 1.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing),
            child: Text(
              text,
              style: textStyle ?? defaultTextStyle,
            ),
          ),
          Expanded(
            child: Divider(
              color: dividerColor ?? defaultDividerColor,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
