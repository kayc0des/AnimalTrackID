// lib/main.dart
import 'package:flutter/material.dart';
import 'features/onboarding/splashscreen_one.dart';
import 'features/intro/intro_screen.dart';
import 'features/onboarding/splashscreen_two.dart';
import 'features/onboarding/splashscreen_three.dart';
import 'features/auth/login.dart';
import 'features/auth/signup.dart';
import 'features/home/home.dart';
import 'features/profile/profile.dart';
import 'features/track/track.dart';
import 'features/submit/submit.dart';
import 'features/submit/submitform.dart';
import 'features/reusables/transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/intro',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/intro':
            return FadePageRoute(page: const IntroScreen());
          case '/onboarding1':
            return FadePageRoute(
                page: const SplashScreenOne(), disableBackButton: true);
          case '/onboarding2':
            return FadePageRoute(
                page: const SplashScreenTwo(), disableBackButton: true);
          case '/onboarding3':
            return FadePageRoute(
                page: const SplashScreenThree(), disableBackButton: true);
          case '/login':
            return FadePageRoute(page: const LoginScreen());
          case '/signup':
            return FadePageRoute(page: const SigninScreen());
          case '/adddata':
            return FadePageRoute(page: const SubmitFormScreen());
          case '/home':
            return FadePageRoute(page: const HomeScreen());
          case '/track':
            return FadePageRoute(page: const TrackScreen());
          case '/submit':
            return FadePageRoute(page: const SubmitScreen());
          case '/profile':
            return FadePageRoute(page: const ProfileScreen());
          default:
            return FadePageRoute(page: const IntroScreen());
        }
      },
    );
  }
}
