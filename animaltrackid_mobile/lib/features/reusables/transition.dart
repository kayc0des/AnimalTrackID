// lib/utils/transitions/slide_transition.dart
import 'package:flutter/material.dart';

class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlidePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide from right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final bool disableBackButton;

  FadePageRoute({required this.page, this.disableBackButton = false})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );

  @override
  bool get canPop => !disableBackButton;

  @override
  TickerFuture didPush() {
    if (disableBackButton) {
      navigator?.removeRouteBelow(this);
    }
    return super.didPush(); // ✅ Correct return type
  }
}
