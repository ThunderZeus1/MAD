import 'package:flutter/material.dart';

class SlideTransitionPage extends PageRouteBuilder {
  final Widget page;
  final AxisDirection direction;

  SlideTransitionPage({required this.page, this.direction = AxisDirection.right})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset beginOffset;
      switch (direction) {
        case AxisDirection.right:
          beginOffset = const Offset(1.0, 0.0);
          break;
        case AxisDirection.left:
          beginOffset = const Offset(-1.0, 0.0);
          break;
        case AxisDirection.up:
          beginOffset = const Offset(0.0, 1.0);
          break;
        case AxisDirection.down:
          beginOffset = const Offset(0.0, -1.0);
          break;
        default:
          beginOffset = const Offset(1.0, 0.0); // Default to right if unspecified
      }
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween<Offset>(begin: beginOffset, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
