import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CasualAppTheme {
  CasualAppTheme._();
  static final ThemeData lightThemeM3 = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: "roboto",
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      background: Colors.grey[50],
      brightness: Brightness.light
    ),
    // -------------------typography-----------------------------
    // typography: Typography.material2021(platform: TargetPlatform.android),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.robotoCondensed(
        fontSize: 57,
        letterSpacing: 0,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: GoogleFonts.robotoCondensed(
        fontSize: 48,
        letterSpacing: 0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: GoogleFonts.robotoCondensed(
        fontSize: 36,
        letterSpacing: 0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
        // headline ---------------------------------------
        headlineLarge: GoogleFonts.robotoCondensed(
          fontSize: 32,
          letterSpacing: 0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        headlineMedium: GoogleFonts.robotoCondensed(
          fontSize: 28,
          letterSpacing: 0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        // headlineSmall: GoogleFonts.robotoCondensed(
        //   fontSize: 24,
        //   letterSpacing: 0,
        //   fontWeight: FontWeight.w400,
        //   fontStyle: FontStyle.normal,
        // ),
        // title ---------------------------------------
        titleLarge: GoogleFonts.robotoCondensed(
          fontSize: 22,
          letterSpacing: 0,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        titleMedium: GoogleFonts.robotoCondensed(
          fontSize: 16,
          letterSpacing: 0.15,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        titleSmall: GoogleFonts.robotoCondensed(
          fontSize: 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        // label ---------------------------------------
        labelLarge: GoogleFonts.robotoCondensed(
          fontSize: 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        labelMedium: GoogleFonts.robotoCondensed(
          fontSize: 12,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
        labelSmall: GoogleFonts.robotoCondensed(
          fontSize: 11,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      // body ---------------------------------------
      bodyLarge: GoogleFonts.robotoCondensed(
        fontSize: 16,
        letterSpacing: 0.15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: GoogleFonts.robotoCondensed(
        fontSize: 14,
        letterSpacing: 0.25,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: GoogleFonts.robotoCondensed(
        fontSize: 12,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),

    ),

    // -------------------buttons----------------------------
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        // padding: MaterialStatePropertyAll(
        //   EdgeInsets.all(16)
        // )
      )
    ),
    filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(16),
        ),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(16),
        ),
      ),
    ),
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.all(16),
        ),
      ),
    ),

    // -------------------Card----------------------------
    cardTheme: CardTheme(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.all(8),
      color: Colors.blue[50],
    ),

    // -------------------ListTile----------------------------
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.all(16),
      // minVerticalPadding: 16.0,
      tileColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.blueGrey.shade900),
      leadingAndTrailingTextStyle: TextStyle(
          color: Colors.blueGrey.shade800, overflow: TextOverflow.ellipsis),
    ),

    expansionTileTheme: const ExpansionTileThemeData(
      tilePadding: EdgeInsets.all(16.0),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      )
    )
  );
}
