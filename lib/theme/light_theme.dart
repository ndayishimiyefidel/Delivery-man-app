import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
ThemeData light = ThemeData(
  fontFamily: 'Rubik',
  brightness: Brightness.light,
  hintColor: Colors.grey,
  shadowColor: const Color(0xfffcf9f4),
  primaryColor: const Color(0xFF0077DB),
  highlightColor: const Color(0xFF1F1F1F),
  focusColor: const Color(0xFF1F1F1F),
  dividerColor: const Color(0xFF2A2A2A),
  errorColor: const Color(0xFFFC6A57),
  primaryColorDark: const Color(0xFFFFFFFF),
  colorScheme: const ColorScheme.light(primary: Color(0xFF0079E3), secondary: Color(0xFF004C8E),
      tertiary: Color(0xFFE5B92C),
    tertiaryContainer: Color(0xFFADC9F3),
      onTertiaryContainer: Color(0xFF33AF74),
      outline: Color(0xFF039D55),
      surface: Color(0xFFEBD27D),
      surfaceTint: Color(0xFF004C8E),

      primaryContainer: Color(0xFF9AECC6),secondaryContainer: Color(0xFFF2F2F2),),

  textTheme: const TextTheme(
    button: TextStyle(color: Colors.white),
    headline1: TextStyle(fontWeight: FontWeight.w300, color: ColorResources.colorBlack, ),
    headline2: TextStyle(fontWeight: FontWeight.w400, color: ColorResources.colorBlack, ),
    headline3: TextStyle(fontWeight: FontWeight.w500, color: ColorResources.colorBlack, ),
    headline4: TextStyle(fontWeight: FontWeight.w600, color: ColorResources.colorBlack, ),
    headline5: TextStyle(fontWeight: FontWeight.w700, color: ColorResources.colorBlack, ),
    headline6: TextStyle(fontWeight: FontWeight.w800, color: ColorResources.colorBlack, ),
    caption: TextStyle(fontWeight: FontWeight.w900, color: ColorResources.colorBlack,),
    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: 12.0),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);