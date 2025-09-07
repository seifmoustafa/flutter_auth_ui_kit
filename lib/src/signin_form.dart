import 'package:flutter/material.dart';
import 'auth_divider.dart';
import 'remember_password.dart';
import 'third_party_auth.dart';

/// A comprehensive signin form widget with customizable fields and styling.
///
/// This widget provides a complete signin form with username/email and password fields,
/// remember me functionality, forgot password link, and social login options.
///
/// ## Features:
/// - **Flexible field configuration**: Support for different input types
/// - **Built-in validation**: Email and password validation
/// - **Social login integration**: Facebook, Google, Apple login buttons
/// - **Remember me functionality**: Checkbox with callback
/// - **Forgot password**: Optional forgot password link
/// - **Customizable styling**: Colors, spacing, and layout options
/// - **Error handling**: Display server errors and validation errors
/// - **Loading states**: Built-in loading indicator support
///
/// ## Usage Example:
/// ```dart
/// SigninForm(
///   onSignin: (email, password, rememberMe) => _handleSignin(email, password, rememberMe),
///   onForgotPassword: () => _showForgotPasswordDialog(),
///   onSocialLogin: (provider) => _handleSocialLogin(provider),
///   isLoading: _isLoading,
///   errorMessage: _errorMessage,
///   emailHint: 'Enter your email',
///   passwordHint: 'Enter your password',
///   signinButtonText: 'Sign In',
///   forgotPasswordText: 'Forgot password?',
/// )
/// ```
class SigninForm extends StatefulWidget {
  /// Creates a [SigninForm] widget.
  ///
  /// The [onSignin] callback is required.
  const SigninForm({
    super.key,
    required this.onSignin,
    this.onForgotPassword,
    this.onSocialLogin,
    this.isLoading = false,
    this.errorMessage,
    this.emailHint = 'Email',
    this.passwordHint = 'Password',
    this.signinButtonText = 'Sign In',
    this.forgotPasswordText = 'Forgot password?',
    this.rememberMeText = 'Remember me',
    this.orText = 'OR',
    this.emailValidator,
    this.passwordValidator,
    this.showSocialLogin = true,
    this.showRememberMe = true,
    this.showForgotPassword = true,
    this.emailInputType = TextInputType.emailAddress,
    this.passwordInputType = TextInputType.visiblePassword,
    this.obscurePassword = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.fieldSpacing = 20.0,
    this.buttonSpacing = 16.0,
    this.socialSpacing = 24.0,
    this.primaryColor,
    this.errorColor,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.fieldHeight = 60.0,
    this.buttonHeight = 50.0,
    this.socialIconSize = 40.0,
    this.facebookIcon,
    this.googleIcon,
    this.appleIcon,
  });

  /// Called when the signin button is pressed.
  /// Parameters: email, password, rememberMe
  final Function(String email, String password, bool rememberMe) onSignin;

  /// Called when the forgot password link is tapped.
  final VoidCallback? onForgotPassword;

  /// Called when a social login button is tapped.
  /// Parameter: 'facebook', 'google', or 'apple'
  final Function(String provider)? onSocialLogin;

  /// Whether the form is in a loading state.
  final bool isLoading;

  /// Error message to display above the form.
  final String? errorMessage;

  /// Hint text for the email field.
  final String emailHint;

  /// Hint text for the password field.
  final String passwordHint;

  /// Text for the signin button.
  final String signinButtonText;

  /// Text for the forgot password link.
  final String forgotPasswordText;

  /// Text for the remember me checkbox.
  final String rememberMeText;

  /// Text for the OR divider.
  final String orText;

  /// Custom validator for the email field.
  final String? Function(String?)? emailValidator;

  /// Custom validator for the password field.
  final String? Function(String?)? passwordValidator;

  /// Whether to show social login buttons.
  final bool showSocialLogin;

  /// Whether to show the remember me checkbox.
  final bool showRememberMe;

  /// Whether to show the forgot password link.
  final bool showForgotPassword;

  /// Input type for the email field.
  final TextInputType emailInputType;

  /// Input type for the password field.
  final TextInputType passwordInputType;

  /// Whether to obscure the password field.
  final bool obscurePassword;

  /// Padding around the entire form.
  final EdgeInsetsGeometry padding;

  /// Spacing between form fields.
  final double fieldSpacing;

  /// Spacing between buttons.
  final double buttonSpacing;

  /// Spacing around social login section.
  final double socialSpacing;

  /// Primary color for buttons and accents.
  final Color? primaryColor;

  /// Color for error messages and validation errors.
  final Color? errorColor;

  /// Background color for the form.
  final Color? backgroundColor;

  /// Border radius for buttons and fields.
  final double borderRadius;

  /// Height of input fields.
  final double fieldHeight;

  /// Height of buttons.
  final double buttonHeight;

  /// Size of social login icons.
  final double socialIconSize;

  /// Asset path for Facebook icon.
  final String? facebookIcon;

  /// Asset path for Google icon.
  final String? googleIcon;

  /// Asset path for Apple icon.
  final String? appleIcon;

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignin() {
    if (_formKey.currentState!.validate()) {
      widget.onSignin(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _rememberMe,
      );
    }
  }

  void _handleSocialLogin(String provider) {
    widget.onSocialLogin?.call(provider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = widget.primaryColor ?? theme.colorScheme.primary;
    final errorColor = widget.errorColor ?? theme.colorScheme.error;
    final backgroundColor = widget.backgroundColor ?? theme.colorScheme.surface;

    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Error message
            if (widget.errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: errorColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: errorColor.withOpacity(0.3)),
                ),
                child: Text(
                  widget.errorMessage!,
                  style: TextStyle(color: errorColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: widget.fieldSpacing),
            ],

            // Email field
            TextFormField(
              controller: _emailController,
              keyboardType: widget.emailInputType,
              decoration: InputDecoration(
                hintText: widget.emailHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: widget.fieldHeight / 4,
                ),
              ),
              validator: widget.emailValidator ?? _defaultEmailValidator,
            ),
            SizedBox(height: widget.fieldSpacing),

            // Password field
            TextFormField(
              controller: _passwordController,
              keyboardType: widget.passwordInputType,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: widget.passwordHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: widget.fieldHeight / 4,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              validator: widget.passwordValidator ?? _defaultPasswordValidator,
            ),
            SizedBox(height: widget.fieldSpacing / 2),

            // Remember me and forgot password
            if (widget.showRememberMe || widget.showForgotPassword)
              RememberPassword(
                rememberMeText: widget.rememberMeText,
                forgotPasswordText: widget.forgotPasswordText,
                onRememberMeChanged: (value) =>
                    setState(() => _rememberMe = value),
                onForgotPasswordTap:
                    widget.showForgotPassword ? widget.onForgotPassword : null,
                checkboxColor: primaryColor,
                padding: EdgeInsets.zero,
              ),
            SizedBox(height: widget.buttonSpacing),

            // Signin button
            ElevatedButton(
              onPressed: widget.isLoading ? null : _handleSignin,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, widget.buttonHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(widget.signinButtonText),
            ),

            // Social login section
            if (widget.showSocialLogin && widget.onSocialLogin != null) ...[
              SizedBox(height: widget.socialSpacing),
              AuthDivider(text: widget.orText),
              SizedBox(height: widget.socialSpacing),
              ThirdPartyAuth(
                facebookIcon: widget.facebookIcon,
                googleIcon: widget.googleIcon,
                appleIcon: widget.appleIcon,
                facebookOnTap: () => _handleSocialLogin('facebook'),
                googleOnTap: () => _handleSocialLogin('google'),
                appleOnTap: () => _handleSocialLogin('apple'),
                iconSize: widget.socialIconSize,
                spacing: widget.socialSpacing,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String? _defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
