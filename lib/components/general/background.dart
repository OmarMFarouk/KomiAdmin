import 'dart:math';

import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: SweepGradient(
              endAngle: 3.7,
              transform: const GradientRotation(pi * 1.5),
              colors: [
            Colors.red.shade700,
            Colors.red.shade400,
            Colors.black
          ])),
    );
  }
}
