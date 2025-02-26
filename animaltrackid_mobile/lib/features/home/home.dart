// lib/features/home/home.dart
import 'package:flutter/material.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/text_group.dart';
import '../reusables/appnav.dart';
import '../../utils/constants/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onBackPressed: () {
          Navigator.pushReplacementNamed(context, '/track');
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
      bottomNavigationBar: AppNavBar(
        currentRoute: ModalRoute.of(context)?.settings.name ?? '/home',
        onTabSelected: (route) {
          if (route != ModalRoute.of(context)?.settings.name) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }
}
