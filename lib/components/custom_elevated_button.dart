import 'package:flutter/material.dart';
import 'package:quapp/utils/color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorClass.buttonColor,
        minimumSize: const Size(170, 40),
      ),
      child: Text(text),
    );
  }
}
