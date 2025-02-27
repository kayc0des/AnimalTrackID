// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../reusables/custom_button.dart';
import '../reusables/custom_input.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/text_group.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/text.dart';

class SubmitFormScreen extends StatelessWidget {
  const SubmitFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnAppBar(
        onBackPressed: () {
          Navigator.pushReplacementNamed(context, '/submit');
        },
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextGroupLeft(
              headerText: 'Hooray! More Data 🎊',
              supportingText: AppTexts.authTextTwo,
            ),
            const SizedBox(height: 24),
            CustomInputField(
              labelText: 'Animal Name',
              labelFontSize: FontConstants.body,
              labelFontWeight: FontConstants.mediumWeight,
              placeholderText: 'Enter Animal Name',
              placeholderFontSize: FontConstants.body,
              placeholderFontWeight: FontConstants.regular,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              labelText: 'Upload Footprint Images',
              labelFontSize: FontConstants.body,
              labelFontWeight: FontConstants.mediumWeight,
              placeholderText: 'Enter Last Name',
              placeholderFontSize: FontConstants.body,
              placeholderFontWeight: FontConstants.regular,
            ),
            const SizedBox(height: 24),
            CustomButton(
              buttonColor: AppColors.primaryColor,
              outlineColor: null,
              text: 'Submit',
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
    );
  }
}
