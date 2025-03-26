import 'package:flutter/material.dart';

class DropShadow {
  static const List<BoxShadow> small = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> large = [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> xLarge = [
    BoxShadow(
      color: Colors.black45,
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];
}
