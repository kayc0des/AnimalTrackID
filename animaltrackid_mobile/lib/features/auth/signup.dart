// lib/features/onboarding/builds.dart
import 'package:animaltrackid/utils/constants/icons.dart';
import 'package:flutter/material.dart';
import '../reusables/custom_button.dart';
import '../reusables/custom_input.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/text_group.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/text.dart';
import '../reusables/separator.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnAppBar(
        onBackPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextGroupLeft(
              headerText: AppTexts.authTitleTwo,
              supportingText: AppTexts.authTextTwo,
            ),
            const SizedBox(height: 24),
            CustomInputField(
              labelText: 'First Name',
              labelFontSize: FontConstants.body,
              labelFontWeight: FontConstants.mediumWeight,
              placeholderText: 'Enter First Name',
              placeholderFontSize: FontConstants.body,
              placeholderFontWeight: FontConstants.regular,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              labelText: 'Last Name',
              labelFontSize: FontConstants.body,
              labelFontWeight: FontConstants.mediumWeight,
              placeholderText: 'Enter Last Name',
              placeholderFontSize: FontConstants.body,
              placeholderFontWeight: FontConstants.regular,
            ),
            const SizedBox(height: 16),
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
              labelText: 'Create Password',
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
              text: 'Create Account',
              textColor: AppColors.whiteColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              onPressed: () {
                // TODO: Add button functionality
              },
            ),
            const SizedBox(height: 32),
            AltSeparator(),
            const SizedBox(height: 32),
            ImageButton(
              buttonColor: AppColors.cardColor,
              outlineColor: AppColors.strokeColor,
              text: 'Sign up with Google',
              textColor: AppColors.textColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              iconPath: AppIcons.google,
              onPressed: () {
                // TODO: Add button functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
