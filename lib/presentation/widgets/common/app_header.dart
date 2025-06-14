import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? title;

  const AppHeader({
    super.key,
    this.showBackButton = true,
    this.onBackPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0x0D12121D),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          // 뒤로가기 버튼
          if (showBackButton)
            GestureDetector(
              onTap: onBackPressed ?? () => Navigator.pop(context),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F4F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Color(0xFF0F1A2A),
                ),
              ),
            ),
          
          const Spacer(),
          
          // 로고 영역 또는 제목
          title ?? Container(
            width: 107,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          
          const Spacer(),
          
          // 여백 (뒤로가기 버튼과 같은 크기)
          if (showBackButton) const SizedBox(width: 28),
        ],
      ),
    );
  }
} 