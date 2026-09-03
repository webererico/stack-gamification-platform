import 'package:flutter/material.dart';

class AppSpaces {
  static SizedBox get vertical4 => const SizedBox(height: 4);
  static SizedBox get vertical8 => const SizedBox(height: 8);
  static SizedBox get vertical12 => const SizedBox(height: 12);
  static SizedBox get vertical16 => const SizedBox(height: 16);
  static SizedBox get vertical20 => const SizedBox(height: 20);
  static SizedBox get vertical24 => const SizedBox(height: 24);
  static SizedBox get vertical32 => const SizedBox(height: 32);
  static SizedBox get vertical48 => const SizedBox(height: 48);

  static SizedBox get horizontal8 => const SizedBox(width: 8);
  static SizedBox get horizontal12 => const SizedBox(width: 12);
  static SizedBox get horizontal16 => const SizedBox(width: 16);
  static SizedBox get horizontal20 => const SizedBox(width: 20);
}

class AppPadding {
  static double get s => 12.0;
  static double get m => 24.0;
  static double get l => 48.0;
}

class PaddingValue {
  static double get s => 12.0;
  static double get m => 24.0;
}

class AppBorder {
  static BorderRadius get radius8 => BorderRadius.circular(8);
  static BorderRadius get radius12 => BorderRadius.circular(12);
  static BorderRadius get radius16 => BorderRadius.circular(16);
  static BorderRadius get radius24 => BorderRadius.circular(24);
}
