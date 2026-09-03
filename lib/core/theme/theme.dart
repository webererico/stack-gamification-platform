import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: AppStyle.body14.fontFamily,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.background,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.fontColor),
    titleTextStyle: AppStyle.heading16,
  ),
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    surface: AppColors.surface,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    color: AppColors.surface,
    shape: RoundedRectangleBorder(borderRadius: AppBorder.radius16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(AppStyle.inputRadius),
    ),
  ),
  useMaterial3: true,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(AppStyle.title14),
      foregroundColor: const WidgetStatePropertyAll(AppColors.primaryColor),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
      textStyle: WidgetStatePropertyAll(
        AppStyle.title14.copyWith(color: Colors.white),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorder.radius12),
      ),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.mutedFontColor,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
      overlayColor: WidgetStatePropertyAll(
        AppColors.outlinedButtonColor.withValues(alpha: 0.2),
      ),
      textStyle: WidgetStatePropertyAll(AppStyle.title14),
      side: const WidgetStatePropertyAll(
        BorderSide(color: AppColors.outlinedButtonColor),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorder.radius12),
      ),
      foregroundColor: const WidgetStatePropertyAll(
        AppColors.outlinedButtonColor,
      ),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
    ),
  ),
);
