import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/presentation/pages/dev_page.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/home_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/calendar/calendar_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/guest_my_page_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/logged_in_my_page_screen.dart';

class MainScreen extends StatefulWidget {

  final int initialIndex;
  final bool isLoggedIn;

  const MainScreen({
    super.key,
    this.initialIndex = 0,
    this.isLoggedIn = false,
  });


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;
    isLoggedIn = widget.isLoggedIn;

  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const MainHomeScreen(),
      const TravelCalendarScreen(),
      isLoggedIn ? const LoggedInMyPageScreen() : const GuestMyPageScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

      ),
    );
  }
}
