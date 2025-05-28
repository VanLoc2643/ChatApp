import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTheme {
  // Colors
  static const Color primaryColor = Color(0xFFFF8383);
  static const Color textColor = Color(0xFF424242);
  static const Color hintColor = Color(0xFFBDBDBD);
  static const Color dividerColor = Color(0xFFBDBDBD);
  static const Color whiteColor = Colors.white;

  // Dimensions
  static const double headerImageOffset = -320;
  static const double horizontalPadding = 24;
  static const double socialButtonSize = 56;
  static const double socialButtonSpacing = 16;
  static const double dividerThickness = 3;
  static const double dividerHeight = 2;
  static const double dividerIndent = 4;
  static const double dividerEndIndent = 300;
  static const double buttonHeight = 65;
  static const double buttonWidth = 343;
  static const double borderRadius = 28;
  static const double iconSize = 20;
  static const double spacing = 15;
  static const double largeSpacing = 30;

  // Text Styles
  static TextStyle get headerStyle => GoogleFonts.rubik(
    color: textColor,
    fontSize: 38,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get labelStyle => GoogleFonts.rubik(
    fontSize: 16,
    letterSpacing: 0.2,
    color: textColor,
  );

  static TextStyle get hintStyle => GoogleFonts.rubik(
    fontSize: 14,
    letterSpacing: 0.2,
    color: hintColor,
  );

  static TextStyle get buttonStyle => GoogleFonts.rubik(
    fontSize: 20,
    letterSpacing: 0.2,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static TextStyle get dividerTextStyle => GoogleFonts.rubik(
    fontSize: 16,
    letterSpacing: 0.2,
    color: hintColor,
  );

  // Input Decoration
  static InputDecoration getInputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: hintColor, size: iconSize),
      prefixText: '| ',
      prefixStyle: hintStyle,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 26,
        maxWidth: 26,
        minHeight: 36,
      ),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: hintStyle,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: hintColor, width: 1),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: hintColor, width: 1),
      ),
    );
  }

  // Button Style
  static ButtonStyle get loginButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    minimumSize: const Size(buttonWidth, buttonHeight),
  );

  // Strings
  static const String signInText = 'Đăng nhập';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Mật khẩu';
  static const String emailHint = 'Nhập email của bạn';
  static const String passwordHint = 'Nhập mật khẩu của bạn';
  static const String orSignInWithText = 'Hoặc đăng nhập với';
  static const String loginButtonText = 'Đăng nhập';
} 