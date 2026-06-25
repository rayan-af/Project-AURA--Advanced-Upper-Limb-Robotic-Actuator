import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class LiquidNeonSignalBar extends StatelessWidget {
  final double fillPercentage; // Muscle signal value from 0.0 to 1.0
  final int rawValue;          // The raw number to display

  const LiquidNeonSignalBar({
    super.key, 
    required this.fillPercentage, 
    required this.rawValue,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Glassmorphism blur
        child: Container(
          width: 90,
          height: 350, // Let's restore the height constraint to ensure it renders correctly
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: 5,
              )
            ],
          ),
          child: LiquidLinearProgressIndicator(
            value: fillPercentage, 
            valueColor: AlwaysStoppedAnimation(
              Colors.cyanAccent.withOpacity(0.8), // The neon fluid color
            ), 
            backgroundColor: Colors.transparent,
            direction: Axis.vertical,
            borderRadius: 50.0,
            // Centered text that floats over the liquid
            center: Text(
              '$rawValue',
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(color: Colors.cyan, blurRadius: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
