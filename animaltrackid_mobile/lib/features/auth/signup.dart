import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../reusables/custom_button.dart';
import '../reusables/custom_input.dart';
import '../reusables/custom_appbar.dart';
import '../reusables/bottom_nav.dart';
import '../reusables/text_group.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/text.dart';
import '../reusables/transition.dart';
import '../reusables/separator.dart';
import '../../utils/constants/icons.dart';
import '../home/home.dart';
import '../reusables/loadingscreen.dart'; // Import LoadingScreen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Email/Password Sign-Up
  Future<void> _signUpWithEmail() async {
    setState(() => _isLoading = true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context)
          .pushReplacement(FadePageRoute(page: const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'An error occurred.');
    }
    setState(() => _isLoading = false);
  }

  // Google Sign-In
  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.of(context)
          .pushReplacement(FadePageRoute(page: const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Google sign-in failed.');
    }
    setState(() => _isLoading = false);
  }

  // Error Display
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: ReturnAppBar(
            onBackPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextGroup(
                          headerText: 'Become A Tracker',
                          supportingText: AppTexts.authTextTwo,
                        ),
                        const SizedBox(height: 24),
                        CustomInputField(
                          controller: _emailController,
                          labelText: 'Email',
                          labelFontSize: FontConstants.body,
                          labelFontWeight: FontConstants.mediumWeight,
                          placeholderText: 'johndoe@example.com',
                          placeholderFontSize: FontConstants.body,
                          placeholderFontWeight: FontConstants.regular,
                        ),
                        const SizedBox(height: 16),
                        PasswordInputField(
                          controller: _passwordController,
                          labelText: 'Password',
                          labelFontSize: FontConstants.body,
                          labelFontWeight: FontConstants.mediumWeight,
                          placeholderText: 'Enter your password',
                          placeholderFontSize: FontConstants.body,
                          placeholderFontWeight: FontConstants.regular,
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          buttonColor: AppColors.primaryColor,
                          outlineColor: null,
                          text: 'Create Account',
                          textColor: AppColors.whiteColor,
                          textSize: FontConstants.body,
                          textWeight: FontConstants.mediumWeight,
                          onPressed: _signUpWithEmail,
                        ),
                        const SizedBox(height: 32),
                        AltSeparator(),
                        const SizedBox(height: 32),
                        ImageButton(
                          buttonColor: AppColors.cardColor,
                          outlineColor: AppColors.strokeColor,
                          text: 'Sign up with Google',
                          textColor: AppColors.textColor,
                          textSize: FontConstants.body,
                          textWeight: FontConstants.mediumWeight,
                          iconPath: AppIcons.google,
                          onPressed: _signInWithGoogle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SignUpNav(
                onPrivacyPressed: () {
                  Navigator.pushReplacementNamed(context, '/privacy');
                },
                onTermsPressed: () {
                  Navigator.pushReplacementNamed(context, '/terms');
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // Fullscreen Loading Overlay
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: AppColors.loadingOverlay, // Semi-transparent background
              child: const Center(
                child: LoadingScreen(
                    size: 60.0), // Use your reusable loading animation
              ),
            ),
          ),
      ],
    );
  }
}
