// lib/features/reusables/custom_navbar.dart
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';

class AuthNavBar extends StatelessWidget {
  final VoidCallback onSignUpPressed;

  const AuthNavBar({super.key, required this.onSignUpPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.strokeColor,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 48),
          child: GestureDetector(
            onTap: onSignUpPressed,
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  fontSize: FontConstants.body,
                  fontWeight: FontConstants.regular,
                  color: AppColors.textColor,
                ),
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: const TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontSize: FontConstants.body,
                      fontWeight: FontConstants.mediumWeight,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
