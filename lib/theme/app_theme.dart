import 'package:appchat/core/constants/app_styles.dart';
import 'package:appchat/core/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.kBackgroundLight,
    primaryColor: AppColors.kPrimaryLight,
    cardColor: AppColors.kWhite,
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
      labelSmall: AppStyles.labelSmallLight,
      labelMedium: AppStyles.labelMediumLight,
      labelLarge: AppStyles.labelLargeLight,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimary,
      secondary: AppColors.kSecondary,
      onSecondary: AppColors.kWhite,
      background: AppColors.kBackgroundLight,
      surface: AppColors.kSurfaceLight,

      error: AppColors.kError,
      onTertiary: AppColors.kActiveColor,
    ),
    canvasColor: AppColors.kIconColorLight,
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
    cardColor: AppColors.kBlack,
    primaryColor: const Color.fromARGB(255, 255, 255, 255),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kSurfaceDark,
      foregroundColor: AppColors.kTextPrimaryDark,
      elevation: Sizes.ELEVATION_0,

      titleTextStyle: AppStyles.titleTextStyleDark,
    ),
    textTheme: TextTheme(
      headlineMedium: AppStyles.headlineMediumDark,
      headlineLarge: AppStyles.headlineLargeDark,
      bodyLarge: AppStyles.bodyLargeDark,
      bodyMedium: AppStyles.bodyMediumDark,
      titleMedium: AppStyles.titleMediumDark,
      titleSmall: AppStyles.titleSmallDark,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.kPrimary,
      secondary: AppColors.kSecondary,
      background: AppColors.kBackgroundDark,
      surface: AppColors.kSurfaceDark,
      error: AppColors.kError,

      onTertiary: AppColors.kActiveColor,
    ),
    canvasColor: AppColors.kIconColorDark,

    iconTheme: const IconThemeData(color: AppColors.kTextPrimaryDark),
  );
}
