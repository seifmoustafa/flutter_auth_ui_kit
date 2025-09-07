import 'package:flutter/material.dart';

/// A widget that combines a "Remember me" checkbox with a "Forgot password?" link.
///
/// This widget is commonly used in authentication forms to provide
/// remember me functionality and password recovery options.
///
/// ## Features:
/// - **Customizable checkbox**: Custom colors, sizes, and styles
/// - **Flexible layout**: Configurable spacing and alignment
/// - **Callback system**: Separate callbacks for checkbox and forgot password
/// - **Accessibility ready**: Proper semantic structure
/// - **Platform adaptive**: Uses platform-appropriate styling
///
/// ## Usage Example:
/// ```dart
/// RememberPassword(
///   rememberMeText: 'Remember me',
///   forgotPasswordText: 'Forgot password?',
///   onRememberMeChanged: (value) => setState(() => _rememberMe = value),
///   onForgotPasswordTap: () => _showForgotPasswordDialog(),
///   checkboxColor: Colors.blue,
///   textColor: Colors.grey,
/// )
/// ```
class RememberPassword extends StatefulWidget {
  /// Creates a [RememberPassword] widget.
  ///
  /// The [onRememberMeChanged] callback is required.
  const RememberPassword({
    super.key,
    required this.onRememberMeChanged,
    this.onForgotPasswordTap,
    this.rememberMeText = 'Remember me',
    this.forgotPasswordText = 'Forgot password?',
    this.checkboxColor,
    this.textColor,
    this.checkboxSize = 20.0,
    this.spacing = 6.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.textStyle,
    this.forgotPasswordStyle,
  });

  /// Called when the remember me checkbox is toggled.
  final ValueChanged<bool> onRememberMeChanged;

  /// Called when the forgot password text is tapped.
  final VoidCallback? onForgotPasswordTap;

  /// Text for the remember me checkbox.
  final String rememberMeText;

  /// Text for the forgot password link.
  final String forgotPasswordText;

  /// Color of the checkbox when checked.
  final Color? checkboxColor;

  /// Color of the text.
  final Color? textColor;

  /// Size of the checkbox.
  final double checkboxSize;

  /// Spacing between checkbox and text.
  final double spacing;

  /// Padding around the entire widget.
  final EdgeInsetsGeometry padding;

  /// Style for the remember me text.
  final TextStyle? textStyle;

  /// Style for the forgot password text.
  final TextStyle? forgotPasswordStyle;

  @override
  State<RememberPassword> createState() => _RememberPasswordState();
}

class _RememberPasswordState extends State<RememberPassword> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextColor = widget.textColor ?? theme.colorScheme.onSurface;
    final defaultCheckboxColor =
        widget.checkboxColor ?? theme.colorScheme.primary;

    return Padding(
      padding: widget.padding,
      child: Row(
        children: [
          // Remember me checkbox
          GestureDetector(
            onTap: () {
              setState(() => _rememberMe = !_rememberMe);
              widget.onRememberMeChanged(_rememberMe);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: widget.checkboxSize,
                  height: widget.checkboxSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _rememberMe
                          ? defaultCheckboxColor
                          : theme.colorScheme.outline,
                      width: 2.0,
                    ),
                    color:
                        _rememberMe ? defaultCheckboxColor : Colors.transparent,
                  ),
                  child: _rememberMe
                      ? Icon(
                          Icons.check,
                          size: widget.checkboxSize * 0.6,
                          color: Colors.white,
                        )
                      : null,
                ),
                SizedBox(width: widget.spacing),
                Text(
                  widget.rememberMeText,
                  style: widget.textStyle ??
                      TextStyle(
                        color: defaultTextColor,
                        fontSize: 14,
                      ),
                ),
              ],
            ),
          ),

          // Push forgot password to the far right
          const Spacer(),

          // Forgot password link
          if (widget.onForgotPasswordTap != null)
            GestureDetector(
              onTap: widget.onForgotPasswordTap,
              child: Text(
                widget.forgotPasswordText,
                style: widget.forgotPasswordStyle ??
                    TextStyle(
                      color: defaultCheckboxColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: defaultCheckboxColor,
                      decorationThickness: 2,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
