// lib/features/reusables/text_group.dart
import 'package:flutter/material.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';

//---------- Centered Text Group ---------- //
class TextGroup extends StatelessWidget {
  final String headerText;
  final String supportingText;

  const TextGroup({
    super.key,
    required this.headerText,
    required this.supportingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            headerText,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.title,
              fontWeight: FontConstants.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            supportingText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.body,
              fontWeight: FontConstants.regular,
              color: AppColors.captionColor,
            ),
          ),
        ],
      ),
    );
  }
}

//---------- Left Aligned Text Group ---------- //
class TextGroupLeft extends StatelessWidget {
  final String headerText;
  final String supportingText;

  const TextGroupLeft({
    super.key,
    required this.headerText,
    required this.supportingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.title,
              fontWeight: FontConstants.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            supportingText,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.body,
              fontWeight: FontConstants.regular,
              color: AppColors.captionColor,
            ),
          ),
        ],
      ),
    );
  }
}

class TextBoxLeft extends StatelessWidget {
  final String headerText;
  // final String supportingText;

  const TextBoxLeft({
    super.key,
    required this.headerText,
    // required this.supportingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.medium,
              fontWeight: FontConstants.bold,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
