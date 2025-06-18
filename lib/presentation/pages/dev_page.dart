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

  Future<void> _showEditAndInsertDialog(String collection) async {
    final data = await _loadSampleJson();
    final List<dynamic> items = data[collection] ?? [];
    if (items.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$collection 샘플 데이터가 없습니다.')),
        );
      }
      return;
    }
    Map<String, dynamic> editableItem = Map<String, dynamic>.from(items.first);
    final controllers = <String, TextEditingController>{};
    editableItem.forEach((key, value) {
      controllers[key] = TextEditingController(text: value?.toString() ?? '');
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$collection 데이터 수정 후 업로드'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: controllers.entries.map((entry) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(labelText: entry.key),
                  ),
                )
              ).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newItem = <String, dynamic>{};
                controllers.forEach((key, controller) {
                  newItem[key] = controller.text;
                });
                await FirebaseFirestore.instance.collection(collection).add(newItem);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$collection 데이터 업로드 완료!')),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('업로드'),
            ),
          ],
        );
      },
    );
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
                    onPressed: () => _showEditAndInsertDialog(col),
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