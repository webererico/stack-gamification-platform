import 'package:flutter/material.dart';

/// Stack Up's palette: a dark, technical "dev-tool dashboard" surface
/// (graphite) with a single vivid accent (volt) doing almost all of the
/// signaling work, plus two supporting accents for tiers and multi-person
/// comparisons.
class AppColors {
  static const background = Color(0xFF0B0D10);
  static const surface = Color(0xFF15181D);
  static const surfaceRaised = Color(0xFF1C2027);
  static const border = Color(0xFF262B33);

  static const fontColor = Color(0xFFF4F6F8);
  static const mutedFontColor = Color(0xFF8A93A1);

  static const primaryColor = Color(0xFFC8FF4D); // "Volt"
  static const secondaryColor = Color(0xFF4DD6FF); // "Signal"
  static const outlinedButtonColor = Color(0xFFFF5D6C);

  // Gamification tiers, reused across skill bars and dev levels.
  static const tierIniciante = Color(0xFF8A93A1);
  static const tierIntermediario = Color(0xFF4DD6FF); // "Signal"
  static const tierAvancado = Color(0xFFFF7A45); // "Ember"
  static const tierExpert = Color(0xFFC8FF4D); // "Volt"

  static const xpTrackColor = Color(0xFF262B33);

  static const success = Color(0xFF2ECC71);
  static const error = Color(0xFFFF5D6C);
  static const warning = Color(0xFFFFB020);

  static const levelGold = Color(0xFFC8FF4D);
}
