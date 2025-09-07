import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable social authentication button for individual providers.
///
/// This widget provides a single social login button that can be used
/// independently or as part of a larger authentication flow.
///
/// ## Features:
/// - **Multiple providers**: Support for Facebook, Google, Apple, and custom providers
/// - **Flexible styling**: Custom colors, sizes, and layouts
/// - **Icon support**: SVG and PNG icon support
/// - **Loading states**: Built-in loading indicator
/// - **Accessibility ready**: Proper semantic structure
///
/// ## Usage Example:
/// ```dart
/// SocialAuthButton(
///   provider: 'google',
///   text: 'Continue with Google',
///   icon: 'assets/icons/google.svg',
///   onPressed: () => _handleGoogleLogin(),
///   isLoading: _isGoogleLoading,
///   backgroundColor: Colors.white,
///   textColor: Colors.black,
///   borderColor: Colors.grey,
/// )
/// ```
class SocialAuthButton extends StatelessWidget {
  /// Creates a [SocialAuthButton] widget.
  ///
  /// The [onPressed] callback is required.
  const SocialAuthButton({
    super.key,
    required this.onPressed,
    this.provider = 'custom',
    this.text = 'Continue',
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.iconColor,
    this.height = 50.0,
    this.borderRadius = 12.0,
    this.borderWidth = 1.0,
    this.iconSize = 20.0,
    this.spacing = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.elevation = 0.0,
    this.shadowColor,
  });

  /// Called when the button is pressed.
  final VoidCallback? onPressed;

  /// Social provider identifier ('facebook', 'google', 'apple', 'custom').
  final String provider;

  /// Text displayed on the button.
  final String text;

  /// Asset path for the icon (SVG or PNG).
  final String? icon;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// Background color of the button.
  final Color? backgroundColor;

  /// Text color of the button.
  final Color? textColor;

  /// Border color of the button.
  final Color? borderColor;

  /// Color of the icon.
  final Color? iconColor;

  /// Height of the button.
  final double height;

  /// Border radius of the button.
  final double borderRadius;

  /// Width of the border.
  final double borderWidth;

  /// Size of the icon.
  final double iconSize;

  /// Spacing between icon and text.
  final double spacing;

  /// Padding around the button content.
  final EdgeInsetsGeometry padding;

  /// Elevation of the button.
  final double elevation;

  /// Shadow color of the button.
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = _getDefaultBackgroundColor(theme);
    final defaultTextColor = _getDefaultTextColor(theme);
    final defaultBorderColor = _getDefaultBorderColor(theme);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? defaultBorderColor,
          width: borderWidth,
        ),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: shadowColor ?? Colors.black.withOpacity(0.1),
                  blurRadius: elevation,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  _buildIcon(),
                  SizedBox(width: spacing),
                ],
                if (isLoading) ...[
                  SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? defaultTextColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spacing),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? defaultTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (icon == null) return const SizedBox.shrink();

    // Try to load as SVG first, fallback to Image.asset
    if (icon!.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        icon!,
        width: iconSize,
        height: iconSize,
        colorFilter: iconColor != null
            ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
            : null,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        icon!,
        width: iconSize,
        height: iconSize,
        color: iconColor,
        fit: BoxFit.contain,
      );
    }
  }

  Color _getDefaultBackgroundColor(ThemeData theme) {
    switch (provider.toLowerCase()) {
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'google':
        return Colors.white;
      case 'apple':
        return Colors.black;
      default:
        return theme.colorScheme.surface;
    }
  }

  Color _getDefaultTextColor(ThemeData theme) {
    switch (provider.toLowerCase()) {
      case 'facebook':
        return Colors.white;
      case 'google':
        return Colors.black87;
      case 'apple':
        return Colors.white;
      default:
        return theme.colorScheme.onSurface;
    }
  }

  Color _getDefaultBorderColor(ThemeData theme) {
    switch (provider.toLowerCase()) {
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'google':
        return Colors.grey.shade300;
      case 'apple':
        return Colors.black;
      default:
        return theme.colorScheme.outline;
    }
  }
}
