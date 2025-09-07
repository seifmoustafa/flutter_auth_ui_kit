# Flutter Auth UI Kit 🔐

A comprehensive Flutter package for authentication UI components including signin forms, social login buttons, dividers, and remember me functionality.

## Features ✨

- **🔐 Complete Signin Form**: Ready-to-use signin form with email/password fields
- **👥 Social Login**: Facebook, Google, and Apple login buttons
- **✅ Remember Me**: Checkbox with forgot password functionality
- **📱 Platform Adaptive**: Automatically adapts to iOS and Android design patterns
- **🎨 Highly Customizable**: Colors, spacing, sizing, and styling options
- **♿ Accessibility Ready**: Proper semantic structure and screen reader support
- **🌍 Localization Ready**: All text is customizable for different languages
- **⚡ Performance Optimized**: Lightweight and efficient widgets

## Installation 📦

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_auth_ui_kit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage 🚀

### Basic Signin Form

```dart
import 'package:flutter_auth_ui_kit/flutter_auth_ui_kit.dart';

SigninForm(
  onSignin: (email, password, rememberMe) {
    // Handle signin logic
    print('Email: $email, Password: $password, Remember: $rememberMe');
  },
  onForgotPassword: () {
    // Handle forgot password
    print('Forgot password tapped');
  },
  onSocialLogin: (provider) {
    // Handle social login
    print('Social login: $provider');
  },
  isLoading: false,
  emailHint: 'Enter your email',
  passwordHint: 'Enter your password',
  signinButtonText: 'Sign In',
)
```

### Social Login Buttons

```dart
ThirdPartyAuth(
  facebookIcon: 'assets/icons/facebook.svg',
  googleIcon: 'assets/icons/google.svg',
  appleIcon: 'assets/icons/apple.svg',
  facebookOnTap: () => _handleFacebookLogin(),
  googleOnTap: () => _handleGoogleLogin(),
  appleOnTap: () => _handleAppleLogin(),
  iconSize: 40.0,
  spacing: 24.0,
)
```

### Individual Social Button

```dart
SocialAuthButton(
  provider: 'google',
  text: 'Continue with Google',
  icon: 'assets/icons/google.svg',
  onPressed: () => _handleGoogleLogin(),
  backgroundColor: Colors.white,
  textColor: Colors.black,
  borderColor: Colors.grey,
)
```

### Remember Me with Forgot Password

```dart
RememberPassword(
  rememberMeText: 'Remember me',
  forgotPasswordText: 'Forgot password?',
  onRememberMeChanged: (value) => setState(() => _rememberMe = value),
  onForgotPasswordTap: () => _showForgotPasswordDialog(),
  checkboxColor: Colors.blue,
  textColor: Colors.grey,
)
```

### Auth Divider

```dart
AuthDivider(
  text: 'OR',
  textStyle: TextStyle(color: Colors.grey),
  dividerColor: Colors.grey.shade300,
  spacing: 16.0,
)
```

## Customization 🎨

### Colors and Theming

```dart
SigninForm(
  primaryColor: Colors.blue,
  errorColor: Colors.red,
  backgroundColor: Colors.white,
  borderRadius: 16.0,
  // ... other properties
)
```

### Spacing and Layout

```dart
SigninForm(
  padding: EdgeInsets.all(24.0),
  fieldSpacing: 24.0,
  buttonSpacing: 20.0,
  socialSpacing: 32.0,
  // ... other properties
)
```

### Field Configuration

```dart
SigninForm(
  emailInputType: TextInputType.emailAddress,
  passwordInputType: TextInputType.visiblePassword,
  obscurePassword: true,
  fieldHeight: 60.0,
  buttonHeight: 50.0,
  // ... other properties
)
```

## Widgets 📱

### SigninForm
Complete signin form with email/password fields, validation, and social login options.

### ThirdPartyAuth
Row of social authentication buttons (Facebook, Google, Apple).

### SocialAuthButton
Individual social authentication button with customizable styling.

### RememberPassword
Remember me checkbox with forgot password link.

### AuthDivider
Horizontal divider with text in the center.

## Dependencies 📋

- `flutter`: SDK
- `flutter_platform_widgets`: Platform-adaptive widgets
- `flutter_svg`: SVG icon support

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support 💬

If you encounter any problems or have suggestions, please file an issue at the [GitHub repository](https://github.com/seifmoustafa/flutter_auth_kit/issues).

---

Made with ❤️ by [seifmoustafa](https://github.com/seifmoustafa)
