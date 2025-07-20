import 'dart:ui';

import 'package:flutter/material.dart';
class FancyProgressIndicator extends StatelessWidget {
  final int step; // From 0 to 4

  const FancyProgressIndicator({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    double progress = (step / 4).clamp(0.0, 1.0); // ensures 0-1 range

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
              ),
            ),
          ),

          // Progress bar
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 20,
            width: MediaQuery.of(context).size.width * progress,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // Border on top
          Container(
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue, width: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
