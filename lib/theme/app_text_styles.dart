import 'package:flutter/material.dart';

class AppTypography {
  // Titles
  static const TextStyle title42Bold = TextStyle(
    fontSize: 42,
    height: 58 / 42,
    fontWeight: FontWeight.bold, // w700
    fontFamily: 'Pretendard',
  );
  static const TextStyle title32Bold = TextStyle(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.bold, // w700
    fontFamily: 'Pretendard',
  );
  static const TextStyle title24Bold = TextStyle(
    fontSize: 24,
    height: 36 / 24,
    fontWeight: FontWeight.bold, // w700
    fontFamily: 'Pretendard',
  );
  static const TextStyle title24Medium = TextStyle(
    fontSize: 24,
    height: 36 / 24,
    fontWeight: FontWeight.w500, // Medium
    fontFamily: 'Pretendard',
  );

  // Subtitles
  static const TextStyle subtitle20Bold = TextStyle(
    fontSize: 20,
    height: 24 / 20,
    fontWeight: FontWeight.bold, // w700
    fontFamily: 'Pretendard',
  );
  static const TextStyle subtitle20Medium = TextStyle(
    fontSize: 20,
    height: 24 / 20,
    fontWeight: FontWeight.w500, // Medium
    fontFamily: 'Pretendard',
  );
  static const TextStyle subtitle18Bold = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.bold, // w700
    fontFamily: 'Pretendard',
  );
  static const TextStyle subtitle18SemiBold = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w600, // SemiBold
    fontFamily: 'Pretendard',
  );
  static const TextStyle subtitle18Medium = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w500, // Medium
    fontFamily: 'Pretendard',
  );
  static const TextStyle subtitle18Regular = TextStyle(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: FontWeight.w400, // Regular
    fontFamily: 'Pretendard',
  );
  static const TextStyle subtitle16SemiBold = TextStyle(
    fontSize: 16,
    height: 20 / 16,
    fontWeight: FontWeight.w600, // SemiBold
    fontFamily: 'Pretendard',
  );

  // Body
  static const TextStyle body16Medium = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600, // SemiBold
    fontFamily: 'Pretendard',
  );
  static const TextStyle body16Regular = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400, // Regular
    fontFamily: 'Pretendard',
  );
  static const TextStyle body14SemiBold = TextStyle(
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w600, // SemiBold
    fontFamily: 'Pretendard',
  );
  static const TextStyle body14Medium = TextStyle(
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w500, // Medium
    fontFamily: 'Pretendard',
  );
  static const TextStyle body14Regular = TextStyle(
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w400, // Regular
    fontFamily: 'Pretendard',
  );

  // Captions
  static const TextStyle caption12Medium = TextStyle(
    fontSize: 12,
    height: 20 / 12,
    fontWeight: FontWeight.w600, // SemiBold
    fontFamily: 'Pretendard',
  );
  static const TextStyle caption12Regular = TextStyle(
    fontSize: 12,
    height: 20 / 12,
    fontWeight: FontWeight.w400, // Regular
    fontFamily: 'Pretendard',
  );
  static const TextStyle caption10Regular = TextStyle(
    fontSize: 10,
    height: 20 / 10,
    fontWeight: FontWeight.w400, // Regular
    fontFamily: 'Pretendard',
  );

  // Action (Buttons & Links)
  static const TextStyle button14 = TextStyle(
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w500, // Medium
    fontFamily: 'Pretendard',
  );
  static const TextStyle link14 = TextStyle(
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w600, // SemiBold
    fontFamily: 'Pretendard',
  );
  static const TextStyle button12 = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500, // Medium
    fontFamily: 'Pretendard',
  );
}

// 사용 예제

// Text('Hello, Flutter!', style: AppTypography.title42Bold);
