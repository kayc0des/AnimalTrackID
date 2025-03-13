// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/transition.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import '../home/home.dart';
import '../reusables/custom_button.dart';
import '../reusables/appnav.dart';

class SubmitScreen extends StatelessWidget {
  const SubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: InfoAppBar(
        onInfoPressed: () {
          Navigator.of(context).pushReplacement(
            FadePageRoute(page: const HomeScreen()),
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImages.submitCard,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              buttonColor: AppColors.primaryColor,
              outlineColor: null,
              text: 'Record New Data Sample',
              textColor: AppColors.whiteColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/adddata');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavBar(
        currentRoute: ModalRoute.of(context)?.settings.name ?? '/submit',
        onTabSelected: (route) {
          if (route != ModalRoute.of(context)?.settings.name) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }
}
