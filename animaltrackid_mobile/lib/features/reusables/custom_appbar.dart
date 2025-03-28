// lib/features/reusables/onboarding_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/icons.dart';

//------- Onboarding App Bar------//
class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSkipPressed;

  const OnboardingAppBar({super.key, required this.onSkipPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const SizedBox.shrink(),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 24),
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

//------- Return App Bar------//
class ReturnAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;

  const ReturnAppBar({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: onBackPressed,
        icon: SvgPicture.asset(
          AppIcons.arrowLeft,
          width: 24,
          height: 24,
          colorFilter:
              const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//------- Home App Bar------//

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;

  const HomeAppBar({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Icon (Menu Button)
            IconButton(
              onPressed: onBackPressed,
              iconSize: 24,
              icon: SvgPicture.asset(
                AppIcons.menuIcon,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),

            // Placeholder for future elements (if needed)
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//------- Info App Bar------//
class InfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onInfoPressed;

  const InfoAppBar({super.key, required this.onInfoPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: onInfoPressed,
            iconSize: 24,
            icon: SvgPicture.asset(
              AppIcons.infoIcon,
              width: 24,
              height: 24,
              colorFilter:
                  const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//------- Return with text ------//
class ReturnTextAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final String title;

  const ReturnTextAppBar(
      {super.key, required this.onBackPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: onBackPressed,
        icon: SvgPicture.asset(
          AppIcons.arrowLeft,
          width: 24,
          height: 24,
          colorFilter:
              const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: FontConstants.fontFamily,
          fontSize: FontConstants.body,
          fontWeight: FontConstants.mediumWeight,
          color: AppColors.textColor,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
