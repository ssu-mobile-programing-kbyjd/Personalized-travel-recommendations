import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeOutAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 4000), // 총 4초로 연장
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn), // 0-1.6초 페이드인
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.elasticOut), // 0-1.6초 스케일
    ));

    _fadeOutAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.75, 1.0, curve: Curves.easeOut), // 3-4초 페이드아웃
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await _animationController.forward();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FF),
              Color(0xFFE8EAFF),
              Color(0xFFD4D7FF),
              Color(0xFFB8BCFF),
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _animationController.value < 0.75
                  ? _fadeAnimation
                  : _fadeOutAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Stack(
                  children: [
                    // 왼쪽 하단 블러 원
                    Positioned(
                      left: -50,
                      bottom: 150,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.indigo40.withOpacity(0.3),
                              blurRadius: 50,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 오른쪽 상단 블러 원
                    Positioned(
                      right: -50,
                      top: 150,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.indigo40.withOpacity(0.3),
                              blurRadius: 50,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 메인 컨텐츠 (중앙)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Trip Block 로고 이미지
                          Container(
                            width: 240,
                            height: 240,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.indigo60.withOpacity(0.3),
                                  blurRadius: 50,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                'assets/logos/vartical_combination.png',
                                width: 137,
                                height: 212,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  // 디버그 정보 출력
                                  print('Image load error: $error');
                                  print('Stack trace: $stackTrace');

                                  // 이미지 로드 실패 시 기본 아이콘 표시
                                  return Container(
                                    width: 137,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.indigo40,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.luggage,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Image\nLoad Error',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // 슬로건
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Text(
                              ':: 여행을 조립하다',
                              style: AppTypography.button12.copyWith(
                                color: AppColors.neutral100,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
