import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }
}
