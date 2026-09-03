import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';

final theme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: AppStyle.body14.fontFamily,
  appBarTheme: AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.background,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.fontColor),
    titleTextStyle: AppStyle.heading16,
  ),
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.primaryColor,
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    surface: AppColors.surface,
  ),
  // Flat, hairline-bordered surfaces instead of drop shadows — the "dev
  // tool dashboard" look rather than the soft, elevated cards of a mobile
  // app.
  cardTheme: CardThemeData(
    elevation: 0,
    color: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: AppBorder.radius16,
      side: const BorderSide(color: AppColors.border),
    ),
  ),
  dividerTheme: const DividerThemeData(color: AppColors.border, space: 32),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceRaised,
    hintStyle: AppStyle.body14,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.circular(AppStyle.inputRadius),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.circular(AppStyle.inputRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
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
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
      textStyle: WidgetStatePropertyAll(
        AppStyle.title14.copyWith(color: AppColors.background),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorder.radius8),
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.background),
      backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
      overlayColor: WidgetStateProperty.all(
        AppColors.background.withValues(alpha: 0.08),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.mutedFontColor,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: AppColors.surface,
    selectedIconTheme: const IconThemeData(color: AppColors.primaryColor),
    unselectedIconTheme: const IconThemeData(color: AppColors.mutedFontColor),
    selectedLabelTextStyle: AppStyle.title12.copyWith(
      color: AppColors.primaryColor,
    ),
    unselectedLabelTextStyle: AppStyle.title12.copyWith(
      color: AppColors.mutedFontColor,
    ),
    indicatorColor: AppColors.primaryColor.withValues(alpha: 0.12),
    useIndicator: true,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
      overlayColor: WidgetStatePropertyAll(
        AppColors.fontColor.withValues(alpha: 0.06),
      ),
      textStyle: WidgetStatePropertyAll(AppStyle.title14),
      side: const WidgetStatePropertyAll(BorderSide(color: AppColors.border)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorder.radius8),
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.fontColor),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: AppColors.background,
    extendedTextStyle: AppStyle.title14.copyWith(color: AppColors.background),
    elevation: 0,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceRaised,
    side: const BorderSide(color: AppColors.border),
    labelStyle: AppStyle.title12,
    shape: RoundedRectangleBorder(borderRadius: AppBorder.radius8),
  ),
);
