import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/Screens/calendar/travel_calendar.dart';
import 'package:personalized_travel_recommendations/Screens/calendar/add_travel_plan_continent_screen.dart';

import 'Screens/calendar/travel_calendar.dart';
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
      home: TravelCalendarScreen(), // 여기!
    );
  }
}
