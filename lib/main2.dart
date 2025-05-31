import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/Screens/guest_my_page_screen.dart';
import 'package:personalized_travel_recommendations/Screens/logged_in_my_page_screen.dart';
import 'package:personalized_travel_recommendations/Screens/my_page_wishlisht_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personalized Travel',
      theme: ThemeData(fontFamily: 'Pretendard'),
      initialRoute: '/mypage',
      routes: {
        '/mypage': (context) => const GuestMyPageScreen(),
        '/mypage/loggedin': (context) => const LoggedInMyPageScreen(), // 로그인 후 이동될 화면
        '/wishlist': (context) => const WishlistScreen(), // 추가
        '/login': (context) => const Placeholder(), // 로그인 화면 (미구현 시 임시)
        '/notice': (context) => const Placeholder(),
        '/support': (context) => const Placeholder(),
      },
    );
  }
}
