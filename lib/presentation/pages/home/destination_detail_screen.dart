import 'package:flutter/material.dart';

class DestinationDetailScreen extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final int hits;
  final String description;
  final String imageUrl;

  const DestinationDetailScreen({
    super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.hits,
    required this.description,
    required this.imageUrl,
  });

  factory DestinationDetailScreen.sagradaFamilia() {
    return const DestinationDetailScreen(
      name: '사그라다 파밀리아',
      location: '스페인 바르셀로나',
      rating: 4.9,
      hits: 8532,
      description:
          '사그라다 파밀리아는 스페인 바르셀로나에 위치한 가우디의 미완성 대성당으로, 독특한 건축미와 웅장함으로 세계적인 명소입니다. 내부의 스테인드글라스와 첨탑, 그리고 낮과 밤이 다른 분위기를 직접 경험해보세요.',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    );
  }

  @override
  Widget build(BuildContext context) {
    final String displayDescription = (description.isNotEmpty)
        ? description
        : '사그라다 파밀리아는 스페인 바르셀로나에 위치한 가우디의 미완성 대성당으로, 독특한 건축미와 웅장함으로 세계적인 명소입니다. 내부의 스테인드글라스와 첨탑, 그리고 낮과 밤이 다른 분위기를 직접 경험해보세요.';
    const String introduceTitle = '명소 소개';
    const String introduceText =
        '성 요셉 축일인 1882년 3월 19일에 착공을 시작한 이 성당은 처음부터 가우디가 설계를 한 것이 아니다. 첫 설계자는 가우디의 스승인 프란시스코 데 폴라 델 빌라르Francisco de Paula del Villar였으며, 1877년부터 설계에 참여하고 있었다. 하지만 착공 1년 만에 건축 기술고문과 의견이 맞지 않아 결국 사임하게 된다. 그리고 그 후임에 가우디가 들어오면서 우리가 아는 역사가 비로소 시작된다.';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 240,
                  color: const Color(0x666680FF),
                  alignment: Alignment.center,
                  child: const Icon(Icons.image,
                      size: 60, color: Color(0xFFB6B6D6)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF21335C),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.star, color: Color(0xFF666680), size: 18),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666680),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${hits.toString()}명이 확인 중',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666680),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Text(
                displayDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF22223B),
                  height: 1.6,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(
                '명소 소개',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF21335C),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Text(
                '성 요셉 축일인 1882년 3월 19일에 착공을 시작한 이 성당은 처음부터 가우디가 설계를 한 것이 아니다. 첫 설계자는 가우디의 스승인 프란시스코 데 폴라 델 빌라르Francisco de Paula del Villar였으며, 1877년부터 설계에 참여하고 있었다. 하지만 착공 1년 만에 건축 기술고문과 의견이 맞지 않아 결국 사임하게 된다. 그리고 그 후임에 가우디가 들어오면서 우리가 아는 역사가 비로소 시작된다.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF22223B),
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
