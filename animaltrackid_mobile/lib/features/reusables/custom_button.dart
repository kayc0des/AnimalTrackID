import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final Color? outlineColor;
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonColor,
    this.outlineColor,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.textWeight,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          side: outlineColor != null
              ? BorderSide(color: outlineColor!)
              : BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: textWeight,
          ),
        ),
      ),
    );
  }
}
