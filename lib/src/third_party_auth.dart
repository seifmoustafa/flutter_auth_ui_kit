import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A row of social authentication icon buttons for Facebook, Google, and Apple.
///
/// This widget provides a clean interface for social login options,
/// automatically hiding Apple login on non-Apple platforms.
///
/// ## Features:
/// - **Platform adaptive**: Automatically shows/hides Apple login based on platform
/// - **Customizable icons**: Support for SVG and PNG icons
/// - **Flexible layout**: Configurable spacing and sizing
/// - **Callback system**: Individual callbacks for each social provider
/// - **Accessibility ready**: Proper semantic structure
///
/// ## Usage Example:
/// ```dart
/// ThirdPartyAuth(
///   facebookIcon: 'assets/icons/facebook.svg',
///   googleIcon: 'assets/icons/google.svg',
///   appleIcon: 'assets/icons/apple.svg',
///   facebookOnTap: () => _handleFacebookLogin(),
///   googleOnTap: () => _handleGoogleLogin(),
///   appleOnTap: () => _handleAppleLogin(),
///   iconSize: 40.0,
///   spacing: 24.0,
/// )
/// ```
class ThirdPartyAuth extends StatelessWidget {
  /// Creates a [ThirdPartyAuth] widget.
  const ThirdPartyAuth({
    super.key,
    this.facebookIcon,
    this.googleIcon,
    this.appleIcon,
    this.facebookOnTap,
    this.googleOnTap,
    this.appleOnTap,
    this.iconSize = 40.0,
    this.spacing = 24.0,
    this.showAppleOnAllPlatforms = false,
  });

  /// Asset path for the Facebook icon.
  final String? facebookIcon;

  /// Asset path for the Google icon.
  final String? googleIcon;

  /// Asset path for the Apple icon.
  final String? appleIcon;

  /// Called when the Facebook icon is tapped.
  final VoidCallback? facebookOnTap;

  /// Called when the Google icon is tapped.
  final VoidCallback? googleOnTap;

  /// Called when the Apple icon is tapped.
  final VoidCallback? appleOnTap;

  /// Size of each social icon.
  final double iconSize;

  /// Spacing between icons.
  final double spacing;

  /// Whether to show Apple icon on all platforms (default: only on Apple platforms).
  final bool showAppleOnAllPlatforms;

  @override
  Widget build(BuildContext context) {
    final icons = <Widget>[];

    // Add Facebook icon if provided
    if (facebookIcon != null && facebookOnTap != null) {
      icons.add(_SocialAuthIcon(
        iconPath: facebookIcon!,
        onTap: facebookOnTap!,
        size: iconSize,
      ));
    }

    // Add Google icon if provided
    if (googleIcon != null && googleOnTap != null) {
      icons.add(_SocialAuthIcon(
        iconPath: googleIcon!,
        onTap: googleOnTap!,
        size: iconSize,
      ));
    }

    // Add Apple icon if provided and on Apple platform or showAppleOnAllPlatforms is true
    if (appleIcon != null && appleOnTap != null) {
      if (showAppleOnAllPlatforms || Platform.isIOS || Platform.isMacOS) {
        icons.add(_SocialAuthIcon(
          iconPath: appleIcon!,
          onTap: appleOnTap!,
          size: iconSize,
        ));
      }
    }

    if (icons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons
          .map((icon) => Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                child: icon,
              ))
          .toList(),
    );
  }
}

/// Internal widget for individual social auth icons.
class _SocialAuthIcon extends StatelessWidget {
  const _SocialAuthIcon({
    required this.iconPath,
    required this.onTap,
    required this.size,
  });

  final String iconPath;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _buildIcon(),
      ),
    );
  }

  Widget _buildIcon() {
    // Try to load as SVG first, fallback to Image.asset
    if (iconPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        iconPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        iconPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    }
  }
}
