import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'no_transition_builder.dart';

// Set Theme for app.

ThemeData themeData = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.aBeeZeeTextTheme(),
    fontFamily: GoogleFonts.aBeeZee().fontFamily,
    colorSchemeSeed: darkBlue,
    appBarTheme: const AppBarTheme(
        surfaceTintColor: darkBlue,
        backgroundColor: darkBlue,
        titleTextStyle: TextStyle(),
        toolbarTextStyle: TextStyle(),
        iconTheme: IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: Colors.white,
    //
    // for web transition fast open page without animation like angular
    //
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : const {},
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: darkBlue,
      surfaceTintColor: darkBlue,
    )));
