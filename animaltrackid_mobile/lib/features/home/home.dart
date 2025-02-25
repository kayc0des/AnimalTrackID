// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/text_group.dart';
import '../reusables/transition.dart';
import '../submit/submit.dart';
import '../../utils/constants/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onBackPressed: () {
          Navigator.of(context).pushReplacement(
            FadePageRoute(page: const SubmitScreen()),
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBoxLeft(
              headerText: 'Explore',
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImages.homeCard,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            TextBoxLeft(
              headerText: 'Track History',
            ),
          ],
        ),
      ),
    );
  }
}
