import 'package:flutter/material.dart';

class MapMarker extends StatelessWidget {
  final String text;
  final Color color;
  const MapMarker({super.key, required this.text, required this.color,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}