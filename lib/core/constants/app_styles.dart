import 'dart:ui';

import 'package:appchat/core/constants/sizes.dart';
import 'package:appchat/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static final TextStyle titleTextStyleLight = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_30,
    fontWeight: FontWeight.bold,
    color: AppColors.kTextPrimaryLight,
  );

  static final TextStyle titleTextStyleDark = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_30,
    fontWeight: FontWeight.bold,
    color: AppColors.kTextPrimaryDark,
  );
  static final TextStyle headlineLargeLight = GoogleFonts.inter(
    fontSize: Sizes.TEXT_SIZE_28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.kTextPrimaryLight,
  );
  static final TextStyle headlineLargeDark = GoogleFonts.inter(
    fontSize: Sizes.TEXT_SIZE_28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.kTextPrimaryDark,
  );

  static final TextStyle headlineMediumLight = GoogleFonts.inter(
    fontSize: Sizes.TEXT_SIZE_20,
    color: AppColors.kTextPrimaryLight,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headlineMediumDark = GoogleFonts.rubik(
    fontSize: Sizes.TEXT_SIZE_20,
    color: AppColors.kTextPrimaryDark,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bodyLargeLight = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_18,
    color: AppColors.kTextPrimaryLight,
  );

  static final TextStyle bodyLargeDark = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_18,
    color: AppColors.kTextPrimaryDark,
  );

  static final TextStyle bodyMediumDark = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_20,
    color: AppColors.kTextPrimaryDark,
  );
  static final TextStyle bodyMediumLight = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_20,
    color: AppColors.kTextPrimaryLight,
  );

  static final TextStyle titleMediumLight = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_22,
    color: AppColors.kTextSecondaryLight,
  );
  static final TextStyle titleMediumDark = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_22,
    color: AppColors.kTextSecondaryDark,
  );

  static final TextStyle titleSmallLight = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_12,
    color: AppColors.kTextSecondaryLight,
  );
  static final TextStyle titleSmallDark = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_12,
    color: AppColors.kTextSecondaryDark,
  );
  static final TextStyle labelSmallLight = GoogleFonts.roboto(
    fontSize: Sizes.TEXT_SIZE_12,
    color: AppColors.kLabelTextPrimary,
  );
}
