// lib/features/onboarding/splash_screen_one.dart
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/text_group.dart';
import '../reusables/custom_button.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/text.dart';
import 'splashscreen_two.dart';
import '../reusables/transition.dart';

class SplashScreenOne extends StatelessWidget {
  const SplashScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnboardingAppBar(
        onSkipPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  // Image
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      AppImages.splashscreenOne,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Text Group
                  TextGroup(
                    headerText: AppTexts.onboardingTitleOne,
                    supportingText: AppTexts.onboardingTextOne,
                  ),
                  const SizedBox(height: 16),

                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.strokeColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.strokeColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Custom Button (Navbar)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: CustomButton(
              buttonColor: AppColors.primaryColor,
              outlineColor: null,
              text: 'Next',
              textColor: AppColors.whiteColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    FadePageRoute(page: const SplashScreenTwo()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
