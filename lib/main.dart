import 'package:flutter/material.dart';
import 'theme/app_shadows.dart'; // DropShadow 클래스 가져오기

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShadowTestScreen(),
    );
  }
}

class ShadowTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DropShadow 테스트')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
    );
  }
}

class ShadowBox extends StatelessWidget {
  final String title;
  final List<BoxShadow> shadow;

  const ShadowBox({required this.title, required this.shadow});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Container(
          width: double.infinity,
          height: 80,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: shadow,
          ),
          child: Center(child: Text('Shadow 적용됨')),
        ),
      ],
    );
  }
}
