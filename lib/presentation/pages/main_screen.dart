import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/presentation/pages/dev_page.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/home_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/calendar/calendar_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/guest_my_page_screen.dart';

class MainScreen extends StatelessWidget {
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
    const GuestMyPageScreen(),
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
      appBar: AppBar(
        title: const Text('메인 화면'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DevPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text('여기에 메인 서비스 UI')),
    );
  }
}
