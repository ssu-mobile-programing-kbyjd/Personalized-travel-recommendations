import 'package:flutter/material.dart';
import 'dev_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
