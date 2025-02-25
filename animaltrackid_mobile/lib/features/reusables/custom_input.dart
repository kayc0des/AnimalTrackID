// lib/features/reusables/custom_input_field.dart
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final String placeholderText;
  final double placeholderFontSize;
  final FontWeight placeholderFontWeight;
  final TextEditingController? controller;

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.labelFontSize,
    required this.labelFontWeight,
    required this.placeholderText,
    required this.placeholderFontSize,
    required this.placeholderFontWeight,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontSize: labelFontSize,
            fontWeight: labelFontWeight,
            color: AppColors.secondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholderText,
            hintStyle: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: placeholderFontSize,
              fontWeight: placeholderFontWeight,
              color: AppColors.captionColor,
            ),
            filled: true,
            fillColor: AppColors.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
      ],
    );
  }
}

class PasswordInputField extends StatefulWidget {
  final String labelText;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final String placeholderText;
  final double placeholderFontSize;
  final FontWeight placeholderFontWeight;
  final TextEditingController? controller;

  const PasswordInputField({
    super.key,
    required this.labelText,
    required this.labelFontSize,
    required this.labelFontWeight,
    required this.placeholderText,
    required this.placeholderFontSize,
    required this.placeholderFontWeight,
    this.controller,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontSize: widget.labelFontSize,
            fontWeight: widget.labelFontWeight,
            color: AppColors.secondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.placeholderText,
            hintStyle: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: widget.placeholderFontSize,
              fontWeight: widget.placeholderFontWeight,
              color: AppColors.captionColor,
            ),
            filled: true,
            fillColor: AppColors.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            suffixIcon: IconButton(
              onPressed: _togglePasswordVisibility,
              icon: SvgPicture.asset(
                _obscureText ? AppIcons.showIcon : AppIcons.hideIcon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                    AppColors.textColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
