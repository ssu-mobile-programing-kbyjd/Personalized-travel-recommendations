import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/theme/app_outline_icons.dart';
import 'package:personalized_travel_recommendations/widget/custom_button.dart';

class TravelCalendarScreen extends StatelessWidget {
  const TravelCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('여행 일정'),
        backgroundColor: AppColors.white,
      ),
    );
  }
}
