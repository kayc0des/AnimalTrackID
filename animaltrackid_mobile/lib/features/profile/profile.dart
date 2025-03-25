// TODO: Profile Screen
// lib/features/onboarding/builds.dart
import 'package:flutter/material.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';
import '../reusables/custom_button.dart';
import '../reusables/appnav.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Profile",
            style: const TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.title,
              fontWeight: FontConstants.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Options Container
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildProfileOption(context, "My Account", () {}),
                  _buildDivider(),
                  _buildProfileOption(context, "Tracking History", () {}),
                  _buildDivider(),
                  _buildProfileOption(context, "Data Contributions", () {}),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildProfileOption(context, "Terms & Condition", () {
                    Navigator.pushReplacementNamed(
                        context, '/termsandconditions');
                  }),
                  _buildDivider(),
                  _buildProfileOption(context, "Privacy Policy", () {
                    Navigator.pushReplacementNamed(context, '/privacypolicy');
                  }),
                  _buildDivider(),
                  _buildProfileOption(context, "Copyright Notice", () {
                    Navigator.pushReplacementNamed(context, '/copyright');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button
            ImageButton(
              buttonColor: AppColors.cardColor,
              outlineColor: AppColors.strokeColor,
              text: 'Logout',
              textColor: AppColors.textColor,
              textSize: FontConstants.body,
              textWeight: FontConstants.mediumWeight,
              iconPath: null,
              onPressed: () async {
                await _logout(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavBar(
        currentRoute: ModalRoute.of(context)?.settings.name ?? '/profile',
        onTabSelected: (route) {
          if (route != ModalRoute.of(context)?.settings.name) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }

  // 📌 Profile Option Row (Left: Label | Right: Arrow)
  Widget _buildProfileOption(
      BuildContext context, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: FontConstants.fontFamily,
                fontSize: FontConstants.body,
                fontWeight: FontConstants.regular,
                color: AppColors.textColor,
              ),
            ),
            SvgPicture.asset(
              AppIcons.next,
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  // 📌 Divider Line
  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.strokeColor,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

Future<void> _logout(BuildContext context) async {
  try {
    // Sign out the user
    await FirebaseAuth.instance.signOut();

    // Navigate to the login or onboarding screen
    Navigator.pushReplacementNamed(
        context, '/login'); // Replace with your login route
  } catch (e) {
    // Handle errors (e.g., show a snackbar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logout failed: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
