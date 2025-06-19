import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalized_travel_recommendations/data/datasources/destinations_dummy_data.dart';
import 'package:personalized_travel_recommendations/data/datasources/influencers_dummy_data.dart';
import '../../data/datasources/user_data.dart';
import '../../data/datasources/trips_data.dart';
import '../../data/datasources/restaurants_data.dart';
import '../../data/datasources/attractions_data.dart';
import '../../data/datasources/flight_data.dart';
import '../../data/datasources/Accommodations_data.dart';
import '../../data/services/firestore_util.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  String selectedCollection = 'users';

  final Map<String, List<Map<String, dynamic>>> sampleDataSets = {
    'users': users,
    'trips': trips,
    'restaurants': jejuRestaurants,
    'attractions': jejuAttractions,
    'flights': jejuFlights,
    'accommodations': jejuAccommodations,
    'influencers': influencersDummyData,
    'destinations': destinationsDummyData
  };

  void _insertCollection(String collection) async {
    final items = sampleDataSets[collection];
    if (items == null || items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$collection 샘플 데이터가 없습니다.')),
      );
      return;
    }
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
    final items = sampleDataSets[collection] ?? [];
    if (items.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$collection 샘플 데이터가 없습니다.')),
        );
      }
      return;
    }
    String jsonString = const JsonEncoder.withIndent('  ').convert(items.first);
    final controller = TextEditingController(text: jsonString);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$collection JSON 데이터 수정 후 업로드'),
          content: TextField(
            controller: controller,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'JSON 데이터',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final parsed = json.decode(controller.text);
                  if (parsed is List) {
                    // 배열이면 여러 개 업로드
                    for (final item in parsed) {
                      await FirebaseFirestore.instance.collection(collection).add(Map<String, dynamic>.from(item));
                    }
                  } else if (parsed is Map) {
                    // 객체면 하나만 업로드
                    await FirebaseFirestore.instance.collection(collection).add(Map<String, dynamic>.from(parsed));
                  }
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$collection 데이터 업로드 완료!')),
                    );
                  }
                  Navigator.of(context).pop();
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('JSON 파싱 오류: $e')),
                    );
                  }
                }
              },
              child: const Text('업로드'),
            ),
          ],
        );
      },
    );
  }

  // 새 컬렉션 생성 다이얼로그
  void _showCreateCollectionDialog() {
    final collectionController = TextEditingController();
    final fieldController = TextEditingController();
    final valueController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('새 Collection 생성'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: collectionController,
                decoration: const InputDecoration(labelText: 'Collection 이름'),
              ),
              TextField(
                controller: fieldController,
                decoration: const InputDecoration(labelText: '필드명 (예: title)'),
              ),
              TextField(
                controller: valueController,
                decoration: const InputDecoration(labelText: '필드 값'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                final col = collectionController.text.trim();
                final field = fieldController.text.trim();
                final value = valueController.text.trim();
                if (col.isNotEmpty && field.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection(col)
                      .add({field: value});
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$col 컬렉션이 생성되었습니다!')),
                    );
                  }
                  setState(() {
                    // 선택된 컬렉션을 새로 만든 것으로 변경
                    selectedCollection = col;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('생성'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDocumentDialog(String collection, String docId, Map<String, dynamic> data) async {
    String jsonString = const JsonEncoder.withIndent('  ').convert(data);
    final controller = TextEditingController(text: jsonString);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$collection 문서 수정'),
          content: TextField(
            controller: controller,
            maxLines: 10,
            decoration: const InputDecoration(
              labelText: 'JSON 데이터',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final newItem = json.decode(controller.text);
                  await FirebaseFirestore.instance.collection(collection).doc(docId).set(newItem);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('문서가 성공적으로 수정되었습니다!')),
                    );
                  }
                  Navigator.of(context).pop();
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('JSON 파싱 오류: $e')),
                    );
                  }
                }
              },
              child: const Text('업데이트'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final collections = [
      'users',
      'trips',
      'packages',
      'influencers',
      'recommendations',
      'likes',
      'posts',
      'schedules',
      'accommodations',
      'attractions',
      'flights',
      'travel_packages',
      'destinations',
      'restaurants',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('개발용 샘플 데이터 등록/조회'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: '새 Collection 생성',
            onPressed: _showCreateCollectionDialog,
          ),
        ],
      ),
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
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: FirestoreUtil.streamCollection<Map<String, dynamic>>(
                collectionName: selectedCollection,
                fromMap: (map) => map,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                }
                final docs = snapshot.data!;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index];
                    return ListTile(
                      title: Text(data['title']?.toString() ?? data['nickname']?.toString() ?? data['uid']?.toString() ?? data['name']?.toString() ?? 'No title'),
                      subtitle: Text(data.toString()),
                      onTap: () => _showEditDocumentDialog(selectedCollection, '', data), // docId는 별도 처리 필요
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