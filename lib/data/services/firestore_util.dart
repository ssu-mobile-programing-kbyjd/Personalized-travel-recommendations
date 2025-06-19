import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtil {
  /// 컬렉션 전체 문서 가져오기 (T: 모델 타입)
  static Future<List<T>> fetchCollection<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
      return snapshot.docs.map((doc) => fromMap(doc.data())).toList();
    } catch (e) {
      print('Firestore fetchCollection error: $e');
      return [];
    }
  }

  /// 실시간 컬렉션 스트림 (T: 모델 타입)
  static Stream<List<T>> streamCollection<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>) fromMap,
  }) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => fromMap(doc.data())).toList());
  }

  /// 문서 추가
  static Future<void> addDocument<T>({
    required String collectionName,
    required T data,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).add(toMap(data));
    } catch (e) {
      print('Firestore addDocument error: $e');
    }
  }

  /// 문서 업데이트 (docId 필요)
  static Future<void> updateDocument<T>({
    required String collectionName,
    required String docId,
    required Map<String, dynamic> Function(T) toMap,
    required T data,
  }) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).doc(docId).update(toMap(data));
    } catch (e) {
      print('Firestore updateDocument error: $e');
    }
  }

  /// 문서 삭제 (docId 필요)
  static Future<void> deleteDocument({
    required String collectionName,
    required String docId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).doc(docId).delete();
    } catch (e) {
      print('Firestore deleteDocument error: $e');
    }
  }
} 