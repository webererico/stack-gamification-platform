import 'package:flutter/material.dart';

/// Distinct, accessible colors used to tell selected teammates apart when
/// overlaying their skill radars in "Monte seu Time".
const List<Color> kTeamBuilderPalette = [
  Color(0xFF6C4CF1),
  Color(0xFF00C2A8),
  Color(0xFFE4536B),
  Color(0xFFFFB020),
  Color(0xFF4C9AFF),
  Color(0xFFB56CFF),
  Color(0xFF2ECC71),
  Color(0xFFFF6F91),
];

int get kTeamBuilderMaxMembers => kTeamBuilderPalette.length;
