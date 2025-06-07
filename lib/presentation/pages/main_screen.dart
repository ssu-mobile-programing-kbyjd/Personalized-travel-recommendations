import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_navbar.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/home_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/calendar/calendar_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/mypage/mypage_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalized_travel_recommendations/data/datasources/sample_data.dart';

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

  Future<Map<String, dynamic>> _loadSampleJson() async {
    final jsonString = await rootBundle.loadString('assets/sample_firestore_data.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  void _insertCollection(String collection) async {
    final data = await _loadSampleJson();
    final List<dynamic> items = data[collection] ?? [];
    for (final item in items) {
      await FirebaseFirestore.instance.collection(collection).add(item);
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$collection 샘플 데이터 등록 완료!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 90, // BottomNavBar 위에 띄우기
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildInsertButton('Users', () => _insertCollection('users')),
                    _buildInsertButton('Trips', () => _insertCollection('trips')),
                    _buildInsertButton('Packages', () => _insertCollection('packages')),
                    _buildInsertButton('Recommendations', () => _insertCollection('recommendations')),
                    _buildInsertButton('Likes', () => _insertCollection('likes')),
                    _buildInsertButton('Posts', () => _insertCollection('posts')),
                    _buildInsertButton('Schedules', () => _insertCollection('schedules')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildInsertButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
