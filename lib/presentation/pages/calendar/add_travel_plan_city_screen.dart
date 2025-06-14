import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/custom_button.dart';
import 'package:personalized_travel_recommendations/presentation/pages/calendar/add_travel_plan_schedule_screen.dart';

class AddTravelPlanCityScreen extends StatefulWidget {
  final String country;
  const AddTravelPlanCityScreen({super.key, required this.country});

  static final Map<String, List<String>> countryCities = {
    // 동아시아
    '국내': ['서울', '부산', '제주', '강릉', '여수', '경주'],
    '일본': ['도쿄', '후쿠오카', '오사카', '가고시마', '나고야', '삿포로', '오키나와'],
    '중국': ['상하이', '베이징', '칭다오', '장자제'],
    '대만': ['타이베이', '지우펀', '단수이', '시먼딩', '예류'],
    '몽골': ['울란바토르', '테를지'],
    // 동남아시아
    '베트남': ['다낭', '하노이', '호치민', '나트랑', '푸꾸옥'],
    '태국': ['방콕', '푸켓', '치앙마이', '파타야'],
    '필리핀': ['세부', '보라카이', '마닐라', '팔라완'],
    // 서아시아
    '터키 (튀르키예)': ['이스탄불', '카파도키아', '에페소'],
    // 남아시아
    '인도': ['델리', '아그라', '자이푸르', '바라나시', '콜카타'],
    '스리랑카': ['콜롬보', '캔디', '갈', '누와라엘리야', '시기리야'],
    // 유럽
    '프랑스': ['파리', '니스', '리옹', '마르세유'],
    '스웨덴': ['스톡홀름', '예테보리', '말뫼', '우프살라', '시그투나'],
    '스위스': ['취리히', '루체른', '인터라켄', '제네바', '융프라우요흐'],
    '노르웨이': ['오슬로', '베르겐', '트롬쇠', '트론헤임'],
    '영국': ['런던', '맨체스터', '에딘버러', '뉴몰든(코리아타운)'],
    // 아프리카
    '남아프리카공화국': ['케이프타운', '요하네스버그', '더반', '스텔렌보스'],
    '에티오피아': ['아디스아바바', '바하르다르', '곤다르'],
    '이집트': ['카이로', '룩소르', '아스완'],
    // 북아메리카
    '미국': ['뉴욕', '로스앤젤레스', '라스베이거스', '샌프란시스코', '하와이(호놀룰루)', '시카고', '워싱턴 D.C.'],
    '캐나다': ['밴쿠버', '토론토', '몬트리올', '퀘벡', '나이아가라폴스'],
    // 남아메리카
    '브라질': ['리우데자네이루', '상파울루', '이과수'],
    '아르헨티나': ['부에노스아이레스', '엘칼라파테', '우수아이아'],
  };

  @override
  State<AddTravelPlanCityScreen> createState() =>
      _AddTravelPlanCityScreenState();
}

class _AddTravelPlanCityScreenState extends State<AddTravelPlanCityScreen> {
  late String country = widget.country;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final cities = AddTravelPlanCityScreen.countryCities[widget.country] ?? [];

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
                        '여행할 도시를 알려주세요.',
                        style: AppTypography.body16Regular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(cities.length, (index) {
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
                        alignment: Alignment.center,
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
                        child: Text(
                          cities[index],
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
            Center(
              child: CustomNextButton(
                text: '다음',
                onPressed: selectedIndex != null
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTravelPlanScheduleScreen(
                                country: country,
                                city: cities[selectedIndex!],
                              ),
                            ));
                      }
                    : () {},
                color: selectedIndex != null
                    ? AppColors.indigo60
                    : AppColors.neutral40,
                textColor: selectedIndex != null
                    ? AppColors.white
                    : AppColors.neutral60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
