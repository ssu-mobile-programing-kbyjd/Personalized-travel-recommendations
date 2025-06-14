import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  String selectedCollection = 'users';

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
    final collections = [
      'users', 'trips', 'packages', 'recommendations', 'likes', 'posts', 'schedules'
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('개발용 샘플 데이터 등록/조회')),
      body: Column(
        children: [
          // 샘플 데이터 등록 버튼
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: collections.map((col) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _insertCollection(col),
                    child: Text(col),
                  ),
                )
              ).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // 컬렉션 선택 드롭다운
          DropdownButton<String>(
            value: selectedCollection,
            items: collections.map((col) =>
              DropdownMenuItem(value: col, child: Text(col))
            ).toList(),
            onChanged: (val) {
              if (val != null) setState(() => selectedCollection = val);
            },
          ),
          const SizedBox(height: 8),
          // Firestore 데이터 조회 (StreamBuilder)
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection(selectedCollection).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data found'));
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['title']?.toString() ?? data['nickname']?.toString() ?? data['uid']?.toString() ?? 'No title'),
                      subtitle: Text(data.toString()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 