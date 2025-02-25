// lib/features/reusables/text_group.dart
import 'package:flutter/material.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';

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
