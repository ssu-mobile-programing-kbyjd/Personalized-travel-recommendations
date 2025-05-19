import 'package:flutter/material.dart';
import 'theme/app_shadows.dart'; // DropShadow 클래스 가져오기
import 'widget/custom_button.dart'; // CustomButton 가져오기
import 'Screens/travel_calander.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShadowTestScreen(),
    );
  }
}

class ShadowTestScreen extends StatelessWidget {
  const ShadowTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DropShadow 테스트')),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShadowBox(title: "Small Shadow", shadow: DropShadow.small),
                  ShadowBox(title: "Medium Shadow", shadow: DropShadow.medium),
                  ShadowBox(title: "Large Shadow", shadow: DropShadow.large),
                  ShadowBox(title: "XLarge Shadow", shadow: DropShadow.xLarge),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: '하단 버튼',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('하단 버튼 클릭됨')),
                );
              },
              color: Colors.blue, // 버튼 배경색 설정
              textColor: Colors.white, // 버튼 텍스트 색상 설정
            ),
          ),
        ],
      ),
    );
  }
}

class ShadowBox extends StatelessWidget {
  final String title;
  final List<BoxShadow> shadow;

  const ShadowBox({super.key, required this.title, required this.shadow});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Container(
          width: double.infinity,
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: shadow,
          ),
          child: const Center(child: Text('Shadow 적용됨')),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
