// TODO: Profile Screen
// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import '../reusables/custom_button.dart';
import '../reusables/text_group.dart';
import '../reusables/appnav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnAppBar(
        onBackPressed: () {},
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
      bottomNavigationBar: AppNavBar(
        currentRoute: ModalRoute.of(context)?.settings.name ?? '/profile',
        onTabSelected: (route) {
          if (route != ModalRoute.of(context)?.settings.name) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }
}
