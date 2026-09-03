import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';

abstract class AppStyle {
  static const inputRadius = 12.0;

  static TextStyle get display28 => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.fontColor,
  );

  static TextStyle get heading20 => GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.fontColor,
  );

  static TextStyle get heading16 => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.fontColor,
  );

  static TextStyle get heading14 => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.fontColor,
  );

  static TextStyle get title14 => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
  );

  static TextStyle get title12 => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
  );

  static TextStyle get body14 =>
      GoogleFonts.inter(fontSize: 14, color: AppColors.mutedFontColor);

  static TextStyle get body16 =>
      GoogleFonts.inter(fontSize: 16, color: AppColors.mutedFontColor);

  static TextStyle get subtitle12 =>
      GoogleFonts.inter(fontSize: 12, color: AppColors.mutedFontColor);

  static TextStyle get subtitle10 =>
      GoogleFonts.inter(fontSize: 10, color: AppColors.mutedFontColor);
}
