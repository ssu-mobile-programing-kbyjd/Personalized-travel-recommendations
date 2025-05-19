import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/Screens/add_travel_plan_continent_screen.dart';
// import 'Screens/travel_calander.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddTravelPlanContinentScreen(), // 여기!
    );
  }
}
