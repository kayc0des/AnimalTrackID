// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/transition.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import '../home/home.dart';
import '../reusables/custom_button.dart';
import '../reusables/text_group.dart';
import '../reusables/appnav.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoAppBar(
        onInfoPressed: () {
          Navigator.of(context).pushReplacement(
            FadePageRoute(page: const HomeScreen()),
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextGroupLeft(
              headerText: 'Footprints found?',
              supportingText:
                  'Take a photo of the footprint or upload a photo to get a classification report. Click on the icon at the top right to learn more',
            ),
            const SizedBox(height: 24),
            CustomButton(
              buttonColor: AppColors.primaryColor,
              outlineColor: null,
              text: 'Classify Footprint',
              textColor: AppColors.whiteColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              onPressed: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavBar(
        currentRoute: ModalRoute.of(context)?.settings.name ?? '/track',
        onTabSelected: (route) {
          if (route != ModalRoute.of(context)?.settings.name) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }
}
