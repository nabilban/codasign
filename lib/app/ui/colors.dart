import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0D1B2A); // Midnight blue
  static const Color surface = Color(
    0xFF1B263B,
  ); // Slightly lighter blue for cards
  static const Color surfaceAlpha = Color(0x801B263B);

  // Accents
  static const Color primary = Color(0xFF00B4D8); // Cyan
  static const Color secondary = Color(0xFF0077B6); // Deeper Cyan
  static const Color accentGlow = Color(
    0xFF90E0EF,
  ); // Very light cyan for glow/highlights

  // Status
  static const Color success = Color(0xFF06D6A0);
  static const Color warning = Color(0xFFFFD166);
  static const Color error = Color(0xFFEF476F);

  // Text
  static const Color textPrimary = Color(0xFFE0E1DD);
  static const Color textSecondary = Color(0xFFA0A0A0);

  // Gradients
  static const List<Color> backgroundGradient = [
    Color(0xFF0D1B2A), // Midnight blue
    Color.fromARGB(57, 0, 118, 182),
    Color(0xFF1B263B), // Deep Navy
  ];
}
