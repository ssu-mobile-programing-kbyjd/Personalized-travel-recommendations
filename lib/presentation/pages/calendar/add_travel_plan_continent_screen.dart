import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_button.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/data/datasources/travel_data.dart';
import 'add_travel_plan_country_screen.dart';
import 'add_travel_plan_schedule_screen.dart';

class AddTravelPlanContinentScreen extends StatefulWidget {
  const AddTravelPlanContinentScreen({super.key});

  @override
  State<AddTravelPlanContinentScreen> createState() =>
      _AddTravelPlanContinentScreenState();
}

class _AddTravelPlanContinentScreenState
    extends State<AddTravelPlanContinentScreen> {
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
                        child: AppOutlinePngIcons.arrowNarrowLeft(
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double itemWidth = (constraints.maxWidth - 16) / 3;
                    double itemHeight = itemWidth * 0.75;
                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          List.generate(TravelData.continents.length, (index) {
                        final isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = isSelected ? null : index;
                            });
                          },
                          child: Container(
                            width: itemWidth,
                            height: itemHeight,
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
                              TravelData.continents[index],
                              style: AppTypography.body14Medium.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
            CustomNextButton(
              text: '다음',
              onPressed: selectedIndex != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTravelPlanCountryScreen(
                            continent: TravelData.continents[selectedIndex!],
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
