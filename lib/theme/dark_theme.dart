import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Rubik',
  brightness: Brightness.dark,
  hintColor: Colors.white,
  shadowColor: const Color(0xfff7f7f7),
  primaryColor: const Color(0xFF03335D),
  primaryColorLight: const Color(0xfff7f7f7),
  highlightColor: const Color(0xFFFFFFFF),
  focusColor: const Color(0xFF8D8D8D),
  dividerColor: const Color(0xFF2A2A2A),
  errorColor: const Color(0xFFCF6679),
  canvasColor: const Color(0xFF041524),
  cardColor: const Color(0xFF263542),

  colorScheme : const ColorScheme.dark(primary: Color(0xFF64BDF9),
    secondary: Color(0xFF3B93DF),
    tertiary: Color(0xFF865C0A),
    tertiaryContainer: Color(0xFFB5CEF7),
    onTertiaryContainer: Color(0xFF35B3E7),
    primaryContainer: Color(0xFF208458),
    surface: Color(0xFF615C34),
    outline: Color(0xFF039D55),
    secondaryContainer: Color(0xFFF2F2F2),),



  textTheme: const TextTheme(
    button: TextStyle(color: Color(0xFFF9FAFA)),
    headline1: TextStyle(fontWeight: FontWeight.w300, color: Color(0xFFF9FAFA)),
    headline2: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFF9FAFA)),
    headline3: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFF9FAFA)),
    headline4: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFF9FAFA)),
    headline5: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFF9FAFA)),
    headline6: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFF9FAFA)),
    caption: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFF9FAFA)),
    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: 12.0),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);
