import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const bg = Color(0xFF050508);
  static const surface = Color(0xFF0C0C14);
  static const card = Color(0xFF14141F);
  static const neonRed = Color(0xFFFF1744);
  static const neonOrange = Color(0xFFFF5722);
  static const neonGold = Color(0xFFFFAB00);
  static const textPrimary = Color(0xFFECECF5);
  static const textMuted = Color(0xFF7A7A96);

  // aliases p/ compatibilidade
  static const primaryRed = neonRed;
  static const warmOrange = neonOrange;
  static const darkBrown = bg;
  static const cream = surface;
  static const lightGray = card;

  static BoxDecoration glass({double r = 16, Color? glow}) {
    final c = glow ?? neonRed;
    return BoxDecoration(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(r),
      border: Border.all(color: c.withValues(alpha: 0.35)),
      boxShadow: [BoxShadow(color: c.withValues(alpha: 0.15), blurRadius: 20)],
    );
  }

  static TextStyle display(double size) =>
      GoogleFonts.orbitron(fontSize: size, fontWeight: FontWeight.bold, color: textPrimary);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: neonRed,
          secondary: neonOrange,
          surface: surface,
        ),
        textTheme: GoogleFonts.rajdhaniTextTheme().apply(bodyColor: textPrimary, displayColor: textPrimary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: neonRed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: GoogleFonts.orbitron(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: card,
          labelStyle: const TextStyle(color: textMuted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: neonRed.withValues(alpha: 0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: neonRed.withValues(alpha: 0.2)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      );
}
