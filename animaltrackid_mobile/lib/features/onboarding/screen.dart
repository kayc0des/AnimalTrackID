// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../reusables/custom_button.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';

class OnboardingBuilds extends StatelessWidget {
  const OnboardingBuilds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomButton(
            buttonColor: AppColors.primaryColor,
            outlineColor: null,
            text: 'Next',
            textColor: AppColors.whiteColor,
            textSize: FontConstants.body,
            textWeight: FontConstants.mediumWeight,
            onPressed: () {
              // TODO: Add button functionality
            },
          ),
        ),
      ),
    );
  }
}
