import 'package:flutter/material.dart';

Map<String, Color> colors = {
  'inverse': Color(0xFF1E333B),
  'default': Color(0xFF808080),
  'gray': Color(0xFFCCCCCC),
  'primary': Color(0xFF185258),
  'info': Color(0xFF2179E0),
  'success': Color(0xFF43A047),
  'warning': Color(0xFFFFB300),
  'danger': Color(0xFFB71C1C),
  'purple': Color(0xFF512DA8),
  'blue': Color(0xFF2E64A3),
  'pink': Color(0xFFE91E63),
  'yellow': Color(0xFFFFC107),
  'black': Colors.black,
  'white': Colors.white,
  'black-hop': Color(0xFF1D1C1C),
};

Map<String, Color> intensities = {
  '900': Color(0xFF000000),
  '700': Color(0xFF333333),
  '600': Color(0xFF666666),
  '500': Color(0xFF808080),
  '400': Color(0xFF999999),
  '300': Color(0xFFB3B3B3),
  '200': Color(0xFFCCCCCC),
  '100': Color(0xFFE5E5E5),
  '50': Color(0xFFFFFFFF),
};

// Accessing the colors:
Color inverseColor = colors['inverse']!;
Color defaultColor = colors['default']!;
Color grayColor = colors['gray']!;
// Add more color variables here

Color primary700Color = colors['primary']!;
Color info700Color = colors['info']!;
Color success700Color = colors['success']!;
Color warning700Color = colors['warning']!;
Color danger700Color = colors['danger']!;
// Add more color variables with different intensities

Color white900Color = colors['white-900']!;
Color white700Color = colors['white-700']!;
Color white600Color = colors['white-600']!;
// Add more color variables for different white intensities

// Accessing the intensities:
Color primary900Color = intensities['900']!;
/* Color primary700Color = intensities['700']!; */
// Add more intensity variables here
