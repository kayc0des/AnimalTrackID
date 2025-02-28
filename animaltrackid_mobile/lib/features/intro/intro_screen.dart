import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // For Lottie animation
import '../../utils/constants/fonts.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/onboarding1');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashColor,
      body: Stack(
        children: [
          // Overlay PNG image that fills the entire screen
          Positioned.fill(
            child: Image.asset(
              AppImages.intro,
              fit: BoxFit.cover,
            ),
          ),

          // Centered Lottie animation
          Center(
            child: Lottie.asset(
              'assets/logo/logo.json',
              fit: BoxFit.contain,
            ),
          ),

          // Bottom text
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "A Capstone Project by Kingsley Budu",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: FontConstants.body,
                  fontWeight: FontConstants.mediumWeight,
                  fontFamily: FontConstants.fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
