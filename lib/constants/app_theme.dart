import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_sadak/constants/app_colors.dart';

//LightTheme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  // textTheme: lightTextTheme,
  textTheme: GoogleFonts.interTextTheme(lightTextTheme),//Theme.of(context).textTheme
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.circularProgressIndicatorBgColor,
  ),
);

TextStyle lightTextStyle = TextStyle(fontSize: 20, color: Colors.black);
TextTheme lightTextTheme = TextTheme(bodyLarge: lightTextStyle);

//DarkTheme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  textTheme: darkTextTheme,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.whiteColor,
  ),
);

TextStyle darkTextStyle = TextStyle(fontSize: 20, color: Colors.white);
TextTheme darkTextTheme = TextTheme(bodyLarge: lightTextStyle);
