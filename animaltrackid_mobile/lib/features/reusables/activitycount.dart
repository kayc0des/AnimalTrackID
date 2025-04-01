import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';

class ActivityCount extends StatelessWidget {
  final String firstLabel;
  final int firstCount;
  final String firstIconPath;
  final String secondLabel;
  final int secondCount;
  final String secondIconPath;

  const ActivityCount({
    super.key,
    required this.firstLabel,
    required this.firstCount,
    required this.firstIconPath,
    required this.secondLabel,
    required this.secondCount,
    required this.secondIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActivityCard(
            label: firstLabel,
            count: firstCount,
            iconPath: firstIconPath,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActivityCard(
            label: secondLabel,
            count: secondCount,
            iconPath: secondIconPath,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard({
    required String label,
    required int count,
    required String iconPath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.splashColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  AppColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  fontSize: FontConstants.small,
                  fontWeight: FontConstants.regular,
                  color: AppColors.whiteColor,
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  fontSize: FontConstants.title,
                  fontWeight: FontConstants.bold,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
