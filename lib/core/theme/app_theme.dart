import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

ThemeData buildAppTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final primaryColor = const Color(0xFF54C5F8); // Flutter Blue
  final bgColor = isDark ? const Color(0xFF0A192F) : const Color(0xFFF8FAFC);
  final surfaceColor = isDark ? const Color(0xFF112240) : const Color(0xFFFFFFFF);
  final textColor = isDark ? const Color(0xFFCCD6F6) : const Color(0xFF1E293B);

  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: bgColor,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
      primary: primaryColor,
      secondary: const Color(0xFF0175C2), // Dart Blue
      surface: surfaceColor,
      onSurface: textColor,
      
      
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData(brightness: brightness).textTheme,
    ).apply(bodyColor: textColor, displayColor: textColor),
  );
}
