// lib/features/reusables/onboarding_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/icons.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSkipPressed;

  const OnboardingAppBar({super.key, required this.onSkipPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const SizedBox.shrink(),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            border: Border.all(color: AppColors.strokeColor, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton.icon(
            onPressed: onSkipPressed,
            icon: SvgPicture.asset(
              AppIcons.arrowRight,
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
            ),
            label: Text(
              'Skip',
              style: TextStyle(
                fontFamily: FontConstants.fontFamily,
                fontSize: FontConstants.body,
                fontWeight: FontConstants.mediumWeight,
                color: AppColors.textColor,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(0, 0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
