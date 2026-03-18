import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF121212);
  static const Color primary = Color(0xFFDC143C); // Vibrant Green
  static const Color textBody = Color(0xFFFDFBD4);
  static const Color textDim = Color(0xB3FDFBD4);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: const TextStyle(fontWeight: FontWeight.w400, letterSpacing: -0.5),
          displayMedium: const TextStyle(fontWeight: FontWeight.w400, letterSpacing: -0.5),
          displaySmall: const TextStyle(fontWeight: FontWeight.w400),
          headlineMedium: const TextStyle(fontWeight: FontWeight.w400),
          titleLarge: const TextStyle(fontWeight: FontWeight.w400),
          bodyLarge: const TextStyle(fontWeight: FontWeight.w300),
          bodyMedium: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ).apply(
        bodyColor: textBody,
        displayColor: textBody,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textDim,
        type: BottomNavigationBarType.fixed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
