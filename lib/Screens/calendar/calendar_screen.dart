import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/screens/calendar/organize_travel_packages.dart';
import 'package:personalized_travel_recommendations/screens/calendar/add_travel_plan_continent_screen.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/widget/custom_button.dart';

class TravelCalendarScreen extends StatelessWidget {
  const TravelCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          '나의 여행 캘린더',
          style: AppTypography.subtitle20Bold,
        ),
        backgroundColor: AppColors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: '여행 계획 추가',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTravelPlanContinentScreen(),
                  ),
                );
              },
              color: AppColors.indigo60,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(
                text: '여행 패키지 추가',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const OrganizeTravelPackagesScreen(),
                    ),
                  );
                },
                color: AppColors.indigo60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
