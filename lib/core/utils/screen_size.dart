import 'package:flutter/material.dart';

class ScreenSize {
  final BuildContext context;

  ScreenSize({required this.context});

  double getHeight() => MediaQuery.of(context).size.height;

  double getWidth() => MediaQuery.of(context).size.width;

  double fontSize(double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return baseSize * 0.8;
    if (width < 1200) return baseSize * 1.0;
    return baseSize * 1.2;
  }
}
