import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../utils/constants/colors.dart';

class LoadingScreen extends StatelessWidget {
  final Color? dotColor;
  final Color? backgroundColor;
  final double size;

  const LoadingScreen({
    super.key,
    this.dotColor,
    this.backgroundColor,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: dotColor ?? AppColors.primaryColor,
          size: size,
        ),
      ),
    );
  }
}
