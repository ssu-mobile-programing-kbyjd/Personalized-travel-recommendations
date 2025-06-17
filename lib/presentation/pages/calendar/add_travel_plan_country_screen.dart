import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_button.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/data/travel_data.dart';
import 'add_travel_plan_city_screen.dart';
import 'add_travel_plan_schedule_screen.dart';

class AddTravelPlanCountryScreen extends StatefulWidget {
  final String continent;
  const AddTravelPlanCountryScreen({super.key, required this.continent});

  @override
  State<AddTravelPlanCountryScreen> createState() =>
      _AddTravelPlanCountryScreenState();
}

class _AddTravelPlanCountryScreenState
    extends State<AddTravelPlanCountryScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final countries = TravelData.continentCountries[widget.continent] ?? [];

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
            // 타이틀
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
                        '여행할 나라를 선택하세요.',
                        style: AppTypography.body16Regular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // 나라 선택 그리드
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // 3개 버튼 + 2*spacing(8) = 3열
                      double itemWidth = (constraints.maxWidth - 16) / 3;
                      double itemHeight = itemWidth * 0.75; // 비율 조정(원하면 변경)
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(countries.length, (index) {
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
                                countries[index],
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
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTravelPlanScheduleScreen(
                      country: widget.continent,
                      city: '${widget.continent}',
                    ),
                  ),
                );
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
                            builder: (context) => AddTravelPlanCityScreen(
                              country: countries[selectedIndex!],
                            ),
                          ));
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
