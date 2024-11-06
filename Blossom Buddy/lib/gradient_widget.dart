import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;

  GradientWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB9CBDA),
            Color(0xFF5587BD)], // Set your gradient colors here
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child, // The child widget wrapped inside the gradient background
    );
  }
}
