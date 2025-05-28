import 'package:appchat/core/constants/app_styles.dart';
import 'package:appchat/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.kBackgroundLight,
    primaryColor: AppColors.kPrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kSurfaceLight,
      foregroundColor: AppColors.kTextPrimaryLight,
      elevation: Sizes.ELEVATION_0,
      titleTextStyle: AppStyles.titleTextStyleLight,
    ),
    textTheme: TextTheme(
      headlineMedium: AppStyles.headlineMediumLight,
      headlineLarge: AppStyles.headlineLargeLight,
      bodyLarge: AppStyles.bodyLargeLight,
      bodyMedium: AppStyles.bodyMediumLight,
      titleMedium: AppStyles.titleMediumLight,
      titleSmall: AppStyles.titleSmallLight,
      labelSmall: GoogleFonts.inter(
        fontSize: Sizes.TEXT_SIZE_12,
        color: AppColors.kLabelTextPrimary,
      ),
      labelMedium: GoogleFonts.rubik(
        fontSize: Sizes.TEXT_SIZE_16,
        color: AppColors.kLabelTextPrimary,
      ),
      labelLarge: GoogleFonts.rubik(
        fontSize: Sizes.TEXT_SIZE_20,
        color: AppColors.kButtonWhite,
        letterSpacing: 0.2,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimary,
      secondary: AppColors.kSecondary,
      background: AppColors.kBackgroundLight,
      surface: AppColors.kSurfaceLight,
      error: AppColors.kError,
    ),
    iconTheme: const IconThemeData(color: AppColors.kTextPrimaryLight),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kButtonWhite,
        foregroundColor: AppColors.kTextPrimaryLight,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.kBackgroundDark,
    primaryColor: AppColors.kPrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kSurfaceDark,
      foregroundColor: AppColors.kTextPrimaryDark,
      elevation: Sizes.ELEVATION_0,
      titleTextStyle: AppStyles.titleTextStyleDark,
    ),
    textTheme: TextTheme(
      headlineMedium: AppStyles.headlineMediumDark,
      headlineLarge: AppStyles.headlineLargeDark,
      bodyLarge: GoogleFonts.roboto(
        fontSize: Sizes.TEXT_SIZE_18,
        color: AppColors.kTextPrimaryDark,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: Sizes.TEXT_SIZE_20,
        color: AppColors.kTextPrimaryDark,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: Sizes.TEXT_SIZE_22,
        color: AppColors.kTextSecondaryDark,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: Sizes.TEXT_SIZE_12,
        color: AppColors.kTextSecondaryDark,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.kPrimary,
      secondary: AppColors.kSecondary,
      background: AppColors.kBackgroundDark,
      surface: AppColors.kSurfaceDark,
      error: AppColors.kError,
    ),
    iconTheme: const IconThemeData(color: AppColors.kTextPrimaryDark),
  );
}
