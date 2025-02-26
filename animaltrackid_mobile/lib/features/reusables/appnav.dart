// lib/features/reusables/app_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/icons.dart';

class AppNavBar extends StatelessWidget {
  final String currentRoute;
  final Function(String) onTabSelected;

  const AppNavBar({
    super.key,
    required this.currentRoute,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        border: Border(
          top: BorderSide(color: AppColors.strokeColor, width: 1),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(48, 0, 48, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(AppIcons.homeIcon, "Home", '/home'),
            _buildNavItem(AppIcons.trackIcon, "Track", '/track'),
            _buildNavItem(AppIcons.submitIcon, "Submit", '/submit'),
            _buildNavItem(AppIcons.profileIcon, "Profile", '/profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, String route) {
    final bool isActive = currentRoute == route;

    return GestureDetector(
      onTap: () => onTabSelected(route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isActive ? AppColors.secondaryColor : AppColors.captionColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.small,
              fontWeight:
                  isActive ? FontConstants.mediumWeight : FontConstants.regular,
              color:
                  isActive ? AppColors.secondaryColor : AppColors.captionColor,
            ),
          ),
        ],
      ),
    );
  }
}
