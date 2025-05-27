import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';

class TravelCalendarScreen extends StatelessWidget {
  const TravelCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('나의 여행 캘린더'),
        backgroundColor: AppColors.white,
      ),
    );
  }
}
