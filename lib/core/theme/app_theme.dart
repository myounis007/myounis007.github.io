import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

ThemeData buildAppTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final primaryColor = const Color(0xFF54C5F8); // Flutter Blue
  final bgColor = isDark ? const Color(0xFF0A192F) : const Color(0xFFF8FAFC);
  final surfaceColor = isDark ? const Color(0xFF112240) : const Color(0xFFFFFFFF);
  final textColor = isDark ? const Color(0xFFCCD6F6) : const Color(0xFF1E293B);

  // Premium typography scale
  final textTheme = TextTheme(
    displayLarge: GoogleFonts.spaceGrotesk(
      fontSize: 64,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.5,
      height: 1.1,
      color: textColor,
    ),
    displayMedium: GoogleFonts.spaceGrotesk(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.0,
      height: 1.1,
      color: textColor,
    ),
    displaySmall: GoogleFonts.spaceGrotesk(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.2,
      color: textColor,
    ),
    headlineLarge: GoogleFonts.spaceGrotesk(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.2,
      color: textColor,
    ),
    headlineMedium: GoogleFonts.spaceGrotesk(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.3,
      color: textColor,
    ),
    titleLarge: GoogleFonts.spaceGrotesk(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: textColor,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: textColor,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.7, // 1.7 line height for excellent readability
      color: textColor.withValues(alpha: 0.8),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.7,
      color: textColor.withValues(alpha: 0.8),
    ),
    labelLarge: GoogleFonts.spaceGrotesk(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
      height: 1.0,
      color: primaryColor,
    ),
  );

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
    textTheme: textTheme,
  );
}
