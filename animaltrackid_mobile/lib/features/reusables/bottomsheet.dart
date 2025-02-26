// lib/features/reusables/photo_picker_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/icons.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerBottomSheet {
  static void show(BuildContext context, Function(XFile?) onImageSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: AppColors.cardColor,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),

              // Heading
              Text(
                "Select an option",
                style: const TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  fontSize: FontConstants.medium,
                  fontWeight: FontConstants.mediumWeight,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 24),

              // Take Photo Option
              _buildOption(
                context,
                icon: AppIcons.camera,
                label: "Take Photo",
                onTap: () =>
                    _pickImage(context, ImageSource.camera, onImageSelected),
              ),

              // Divider
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.strokeColor,
                margin: const EdgeInsets.symmetric(vertical: 12),
              ),

              // Select from Gallery Option
              _buildOption(
                context,
                icon: AppIcons.photo,
                label: "Select from Gallery",
                onTap: () =>
                    _pickImage(context, ImageSource.gallery, onImageSelected),
              ),
              const SizedBox(height: 64),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildOption(BuildContext context,
      {required String icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
                AppColors.secondaryColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.body,
              fontWeight: FontConstants.regular,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _pickImage(BuildContext context, ImageSource source,
      Function(XFile?) onImageSelected) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    Navigator.pop(context);
    onImageSelected(image);
  }
}
