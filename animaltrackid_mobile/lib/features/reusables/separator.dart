// lib/features/reusables/alt_separator.dart
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';

class AltSeparator extends StatelessWidget {
  const AltSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.strokeColor,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'OR',
          style: const TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontSize: FontConstants.small,
            fontWeight: FontConstants.regular,
            color: AppColors.captionColor,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.strokeColor,
          ),
        ),
      ],
    );
  }
}
