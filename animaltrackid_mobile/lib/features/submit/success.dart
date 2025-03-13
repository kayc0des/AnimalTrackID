import 'package:flutter/material.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/paw.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              "Successfully Submitted",
              style: TextStyle(
                fontFamily: FontConstants.fontFamily,
                fontSize: FontConstants.title,
                fontWeight: FontConstants.mediumWeight,
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
