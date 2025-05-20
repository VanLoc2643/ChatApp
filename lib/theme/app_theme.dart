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
        backgroundColor:  AppColors.kSurfaceLight,
        foregroundColor: AppColors.kTextPrimaryLight,
        elevation: Sizes.ELEVATION_0,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: Sizes.TEXT_SIZE_30,
          fontWeight: FontWeight.bold,
          color: AppColors.kTextPrimaryLight
        ),
      ),
      textTheme: TextTheme(
          headlineMedium: GoogleFonts.inter(
            fontSize: Sizes.TEXT_SIZE_20,
            color: AppColors.kTextPrimaryLight,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: GoogleFonts.inter(
            fontSize: Sizes.TEXT_SIZE_28,
            fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: AppColors.kTextPrimaryLight
          ),
          bodyLarge: GoogleFonts.roboto(
              fontSize: Sizes.TEXT_SIZE_18,
              color: AppColors.kTextPrimaryLight),
          bodyMedium:  GoogleFonts.roboto(
              fontSize: Sizes.TEXT_SIZE_20,
              color: AppColors.kTextPrimaryLight),
          titleMedium: GoogleFonts.roboto(
              fontSize: Sizes.TEXT_SIZE_22,
              color: AppColors.kTextSecondaryLight),
          titleSmall: GoogleFonts.roboto(
              fontSize: Sizes.TEXT_SIZE_12,
              color: AppColors.kTextSecondaryLight),
          labelMedium: GoogleFonts.inter(
              fontSize: Sizes.TEXT_SIZE_12,
              color: AppColors.kLabelTextPrimary),
      ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimary,
      secondary: AppColors.kSecondary,
      background: AppColors.kBackgroundLight,
      surface: AppColors.kSurfaceLight,
      error: AppColors.kError,
    ),
    iconTheme: const IconThemeData(color: AppColors.kTextPrimaryLight),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.kBackgroundDark,
    primaryColor: AppColors.kPrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kSurfaceDark,
      foregroundColor: AppColors.kTextPrimaryDark,
      elevation: Sizes.ELEVATION_0,
      titleTextStyle: GoogleFonts.roboto(
        color: AppColors.kTextPrimaryDark,
        fontSize: Sizes.TEXT_SIZE_30,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme:  TextTheme(
      headlineMedium: GoogleFonts.luckiestGuy(
        fontSize: Sizes.TEXT_SIZE_34,
          fontWeight: FontWeight.w800,
          color: AppColors.kTextPrimaryDark
      ),
      headlineLarge: GoogleFonts.luckiestGuy(
          fontSize: Sizes.TEXT_SIZE_40,
          fontWeight: FontWeight.w900,
          color: AppColors.kTextPrimaryDark
      ),
      bodyLarge: GoogleFonts.roboto(
          fontSize: Sizes.TEXT_SIZE_18,
          color: AppColors.kTextPrimaryDark),
      bodyMedium:  GoogleFonts.roboto(
          fontSize: Sizes.TEXT_SIZE_20,
          color: AppColors.kTextPrimaryDark),
      titleMedium: GoogleFonts.roboto(
          fontSize: Sizes.TEXT_SIZE_22,
          color: AppColors.kTextSecondaryDark),
      titleSmall: GoogleFonts.roboto(
          fontSize: Sizes.TEXT_SIZE_12,
          color: AppColors.kTextSecondaryDark),
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
