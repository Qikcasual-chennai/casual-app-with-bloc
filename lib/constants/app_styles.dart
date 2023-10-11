import 'package:flutter/material.dart';

// Color primary = const Color(0x2F196B);

class Styles{
  // static Color primaryColor = primary;
  static Color secondaryColor = const Color(0xFFE47B01);
  static Color lightBgColor = const Color(0xFFF8FDFF);
  static Color darkBgColor = const Color(0xFF2E394A);
  static Color lightBlueColor = const Color(0xFFF1FCFF);

  // ================Text=====================
  static Color textColor = const Color(0xFF00313E);
  static Color textLightColor = const Color(0xFF757575);
  static TextStyle textStyle = TextStyle(fontSize: 16, color: textColor,fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 = TextStyle(fontSize: 26, color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 = TextStyle(fontSize: 21, color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 = TextStyle(fontSize: 17, color: textColor,fontWeight: FontWeight.w500);
  static TextStyle headLineStyle4 = TextStyle(fontSize: 14, color: textColor,fontWeight: FontWeight.w500);

  // ===========Alert Color====
  static Color successColor = const Color(0xFF7EC15F);
  static Color errorColor = const Color(0xFFDA0424);
  static Color warningColor = const Color(0xFFFFBB01);

  // ========Primary==============
  static const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFE6E3ED),
    100: Color(0xFFC1BAD3),
    200: Color(0xFF978CB5),
    300: Color(0xFF6D5E97),
    400: Color(0xFF4E3C81),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFF2A1663),
    700: Color(0xFF231258),
    800: Color(0xFF1D0E4E),
    900: Color(0xFF12083C),
  });
  static const int _primaryPrimaryValue = 0xFF2F196B;

  static const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFF8774FF),
    200: Color(_primaryAccentValue),
    400: Color(0xFF300EFF),
    700: Color(0xFF2300F3),
  });
  static const int _primaryAccentValue = 0xFF5C41FF;
}