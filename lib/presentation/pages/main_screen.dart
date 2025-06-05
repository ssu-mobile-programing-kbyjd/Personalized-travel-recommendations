import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/widget/custom_navbar.dart';
import 'package:personalized_travel_recommendations/screens/home/home_screen.dart';
import 'package:personalized_travel_recommendations/screens/calendar/calendar_screen.dart';
import 'package:personalized_travel_recommendations/screens/mypage/mypage_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 화면 리스트 정의
  final List<Widget> _screens = [
    const HomeScreen(),
    const TravelCalendarScreen(),
    const MyPageScreen(),
  ];

  // 페이지 전환 메소드
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
