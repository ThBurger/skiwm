import 'package:flutter/material.dart';

class SkiWmStyle {
  static const buttonHeight = 44.0;
  static BorderRadius borderRadius = BorderRadius.circular(8);
  static LinearGradient gradient =
      const LinearGradient(colors: [Colors.cyan, Colors.indigo]);
  static LinearGradient gradientGrey =
      const LinearGradient(colors: [Colors.grey, Colors.grey]);
}

class SkiWmColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color initial = Color.fromRGBO(23, 43, 77, 1.0);
  static const Color primary = Color.fromRGBO(94, 114, 228, 1.0);
  static const Color secondary = Color.fromRGBO(247, 250, 252, 1.0);
  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);
  static const Color info = Color.fromRGBO(17, 205, 239, 1.0);
  static const Color error = Color.fromRGBO(245, 54, 92, 1.0);
  static const Color success = Color.fromRGBO(45, 206, 137, 1.0);
  static const Color warning = Color.fromRGBO(251, 99, 64, 1.0);
  static const Color header = Color.fromRGBO(82, 95, 127, 1.0);
  static const Color bgColorScreen = Color.fromRGBO(248, 249, 254, 1.0);
  static const Color border = Color.fromRGBO(202, 209, 215, 1.0);
  static const Color inputSuccess = Color.fromRGBO(123, 222, 177, 1.0);
  static const Color inputError = Color.fromRGBO(252, 179, 164, 1.0);
  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);
  static const Color text = Color.fromRGBO(50, 50, 93, 1.0);

  // new colors? https://nordvpn.com/
  static const Color textNew = Color.fromRGBO(56, 60, 67, 1.0);
  static const Color backgroundNew = Color.fromRGBO(248, 248, 248, 1.0);
  static const Color primaryNew = Color.fromRGBO(70, 135, 255, 1.0);
  static const Color successNew = Color.fromRGBO(39, 190, 86, 1.0);
  static const Color warningNew = Color.fromRGBO(250, 149, 162, 1.0);
}
