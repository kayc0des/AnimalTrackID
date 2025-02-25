// lib/features/onboarding/builds.dart
import 'package:animaltrackid/features/onboarding/splashscreen_one.dart';
import 'package:flutter/material.dart';
import '../reusables/custom_button.dart';
import '../reusables/custom_input.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/bottom_nav.dart';
import '../reusables/text_group.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/text.dart';
import '../reusables/transition.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnAppBar(
        onBackPressed: () {
          Navigator.of(context)
              .pushReplacement(FadePageRoute(page: const SplashScreenOne()));
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextGroup(
                      headerText: AppTexts.authTitleOne,
                      supportingText: AppTexts.authTextOne,
                    ),
                    const SizedBox(height: 24),
                    CustomInputField(
                      labelText: 'Email',
                      labelFontSize: FontConstants.body,
                      labelFontWeight: FontConstants.mediumWeight,
                      placeholderText: 'johndoe@example.com',
                      placeholderFontSize: FontConstants.body,
                      placeholderFontWeight: FontConstants.regular,
                    ),
                    const SizedBox(height: 16),
                    PasswordInputField(
                      labelText: 'Password',
                      labelFontSize: FontConstants.body,
                      labelFontWeight: FontConstants.mediumWeight,
                      placeholderText: 'Enter your password',
                      placeholderFontSize: FontConstants.body,
                      placeholderFontWeight: FontConstants.regular,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      buttonColor: AppColors.primaryColor,
                      outlineColor: null,
                      text: 'Login',
                      textColor: AppColors.whiteColor,
                      textSize: FontConstants.body,
                      textWeight: FontConstants.mediumWeight,
                      onPressed: () {
                        // TODO: Add button functionality
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          AuthNavBar(
            onSignUpPressed: () {
              // TODO: Handle sign-up navigation
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
