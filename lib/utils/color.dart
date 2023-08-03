import 'package:flutter/material.dart';

class ColorClass {
  static Color customColor1 = const Color.fromARGB(255, 255, 153, 102);
  static Color customColor2 = const Color.fromARGB(255, 255, 94, 98);
  static Color buttonColor = const Color.fromARGB(255, 243, 110, 33);
}

class ColorGradientClass {
  static Gradient mainGradient = const LinearGradient(
    colors: [Color(0xFFFF9966), Color(0xFFFF5E62)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
