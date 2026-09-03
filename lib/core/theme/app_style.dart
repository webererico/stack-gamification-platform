import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';

/// Type system: Space Grotesk for headings (distinctive, geometric),
/// IBM Plex Sans for body/UI copy, and IBM Plex Mono for every number that
/// matters — XP, ratings, percentages — the "readout" pattern that signals
/// a data/dev tool rather than a generic mobile app.
abstract class AppStyle {
  static const inputRadius = 10.0;

  static TextStyle get display28 => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
    letterSpacing: -0.3,
  );

  static TextStyle get heading20 => GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
    letterSpacing: -0.2,
  );

  static TextStyle get heading16 => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
    letterSpacing: -0.1,
  );

  static TextStyle get heading14 => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
  );

  static TextStyle get title14 => GoogleFonts.ibmPlexSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.fontColor,
  );

  static TextStyle get title12 => GoogleFonts.ibmPlexSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.fontColor,
  );

  static TextStyle get body14 =>
      GoogleFonts.ibmPlexSans(fontSize: 14, color: AppColors.mutedFontColor);

  static TextStyle get body16 =>
      GoogleFonts.ibmPlexSans(fontSize: 16, color: AppColors.mutedFontColor);

  static TextStyle get subtitle12 =>
      GoogleFonts.ibmPlexSans(fontSize: 12, color: AppColors.mutedFontColor);

  static TextStyle get subtitle10 =>
      GoogleFonts.ibmPlexSans(fontSize: 10, color: AppColors.mutedFontColor);

  static TextStyle get overline => GoogleFonts.ibmPlexMono(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedFontColor,
    letterSpacing: 1.2,
  );

  /// For every number that matters: XP, ratings, percentages.
  static TextStyle get dataLarge => GoogleFonts.ibmPlexMono(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.fontColor,
  );

  static TextStyle get dataMedium => GoogleFonts.ibmPlexMono(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.fontColor,
  );

  static TextStyle get dataSmall =>
      GoogleFonts.ibmPlexMono(fontSize: 11, color: AppColors.mutedFontColor);
}
