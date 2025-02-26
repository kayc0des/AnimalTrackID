// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/transition.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import 'track.dart';
import '../reusables/custom_button.dart';
import '../reusables/text_group.dart';

class ClassificationResultScreen extends StatelessWidget {
  const ClassificationResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnAppBar(
        onBackPressed: () {
          Navigator.of(context).pushReplacement(
            FadePageRoute(page: const TrackScreen()),
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextGroupLeft(
              headerText: 'Classification Report',
              supportingText:
                  'Your track has been recorded, find below a classification report.',
            ),
            const SizedBox(height: 24),
            CustomButton(
              buttonColor: AppColors.primaryColor,
              outlineColor: null,
              text: 'Learn More',
              textColor: AppColors.whiteColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
