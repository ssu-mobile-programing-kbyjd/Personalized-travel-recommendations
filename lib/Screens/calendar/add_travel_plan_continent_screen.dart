import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/widget/custom_button.dart';
import 'package:personalized_travel_recommendations/theme/app_outline_icons.dart';
import 'add_travel_plan_country_screen.dart';

class AddTravelPlanContinentScreen extends StatefulWidget {
  const AddTravelPlanContinentScreen({super.key});

  @override
  State<AddTravelPlanContinentScreen> createState() =>
      _AddTravelPlanContinentScreenState();
}

class _AddTravelPlanContinentScreenState
    extends State<AddTravelPlanContinentScreen> {
  final List<String> continents = [
    '동아시아',
    '동남아시아',
    '서아시아',
    '남아시아',
    '유럽',
    '아프리카',
    '북아메리카',
    '남아메리카',
  ];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // 타이틀
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.neutral10,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: AppOutlineIcons.arrowNarrowLeft(
                            color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 42),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '어디로\n떠나실 계획인가요?',
                        style: AppTypography.title24Bold,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '여행할 대륙을 알려주세요.',
                        style: AppTypography.body16Regular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // 대륙 선택 그리드
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(continents.length, (index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = isSelected ? null : index;
                        });
                      },
                      child: Container(
                        width: 114,
                        height: 86,
                        decoration: BoxDecoration(
                          color: AppColors.neutral10,
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.indigo60,
                                  width: 2,
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          continents[index],
                          style: AppTypography.body14Medium.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                print('아직 안정했어요');
                // Handle the action for "아직 안정했어요" button
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 32),
                child: Text(
                  '아직 안정했어요',
                  style: AppTypography.body14Regular.copyWith(
                    color: AppColors.neutral60,
                  ),
                ),
              ),
            ),
            CustomNextButton(
              text: '다음',
              onPressed: selectedIndex != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTravelPlanCountryScreen(
                            continent: continents[selectedIndex!],
                          ),
                        ),
                      );
                    }
                  : () {},
              color: selectedIndex != null
                  ? AppColors.indigo60
                  : AppColors.neutral40,
              textColor:
                  selectedIndex != null ? AppColors.white : AppColors.neutral60,
            ),
          ],
        ),
      ),
    );
  }
}
