import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/screens/main_screen.dart';
import 'package:personalized_travel_recommendations/Screens/mypage/guest_my_page_screen.dart';
import 'package:personalized_travel_recommendations/Screens/mypage/logged_in_my_page_screen.dart';
import 'package:personalized_travel_recommendations/Screens/mypage/my_page_wishlisht_screen.dart';


void main() {
  runApp(const MyApp(isTest: true)); // 테스트용 실행
}

class MyApp extends StatelessWidget {
  final bool isTest;
  const MyApp({super.key, this.isTest = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Recommendations',
      theme: ThemeData(fontFamily: 'Pretendard'),
      initialRoute: isTest ? '/guest' : '/',
      routes: {
        '/guest': (context) => const GuestMyPageScreen(),
        '/mypage/loggedin': (context) => const LoggedInMyPageScreen(), // 로그인 후 이동될 화면
        '/wishlist': (context) => const WishlistScreen(), // 추가
        '/login': (context) => const Placeholder(), // 로그인 화면 (미구현 시 임시)
        '/notice': (context) => const Placeholder(),
        '/support': (context) => const Placeholder(),
      },
    );
  }
}
