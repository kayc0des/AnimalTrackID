import 'package:flutter/material.dart';
import '../../utils/constants/fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            fontFamily: FontConstants.fontFamily,
            color: textColor,
            fontSize: textSize,
            fontWeight: textWeight,
          ),
        ),
      ),
    );
  }
}

// lib/features/reusables/custom_button.dart

class ImageButton extends StatelessWidget {
  final Color buttonColor;
  final Color? outlineColor;
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;
  final VoidCallback onPressed;
  final String? iconPath; // Optional SVG icon

  const ImageButton({
    super.key,
    required this.buttonColor,
    this.outlineColor,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.textWeight,
    required this.onPressed,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: buttonColor,
            border: outlineColor != null
                ? Border.all(color: outlineColor!, width: 1)
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconPath != null) ...[
                SvgPicture.asset(
                  iconPath!,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  color: textColor,
                  fontSize: textSize,
                  fontWeight: textWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
