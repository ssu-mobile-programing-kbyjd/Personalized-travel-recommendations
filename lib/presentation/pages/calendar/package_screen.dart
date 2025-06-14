import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_solid_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';

class TravelPackage extends StatefulWidget {
  final Map travelInfo;
  const TravelPackage({super.key, required this.travelInfo});

  @override
  State<TravelPackage> createState() =>
      _TravelPackage();
}

class _TravelPackage extends State<TravelPackage> {
  late Map travelInfo = widget.travelInfo;

  int activeIndex = 0;
  static const List<String> _imagePaths = [
    'assets/images/CasaMila.png',
    'assets/images/contents.png',
    'assets/images/SagradaFamilia.png',
    'assets/images/TokyoRestaurants.png',
  ];

  static const List<List<Map>> travelSchedule = [
    [
      {
        'place':'티웨이항공 GMP 11:25 - TSA 13:10',
        'address':'인천국제공항 2터미널',
        'price':130000,
        'time':TimeOfDay(hour: 11, minute: 25),
      },
      {
        'place':'신주쿠 호텔',
        'address':'1-1 Maihama, Maihama, Urayasu',
        'price':250000,
        'time':TimeOfDay(hour: 13, minute: 50),
      },
      {
        'place':'신주쿠 공원',
        'address':'1-1 Maihama, Maihama, Urayasu 279-0031 Chiba Prefecture',
        'price':0,
        'time':TimeOfDay(hour: 15, minute: 25),
      },
    ]
  ];

  List<Color> travelDailyColors = [
    AppColors.cyan20,
    AppColors.lime20,
    AppColors.purple20,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 53,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "여행 추가",
                      style: AppTypography.subtitle16SemiBold.copyWith(color: AppColors.neutral100),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(28)),
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: AppColors.neutral10,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: AppOutlinePngIcons.arrowNarrowLeft(color: Colors.black, size: 20,),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: _imagePaths.map((path) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    child: Image.asset(
                                      path,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  );
                                },);
                            }).toList(),
                            options: CarouselOptions(
                              height: 194,
                              autoPlay: false,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              initialPage: 0,
                              onPageChanged: (index, reason) => setState(() {
                                activeIndex = index;
                              }),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                alignment: Alignment.bottomCenter,
                                child: AnimatedSmoothIndicator(
                                  activeIndex: activeIndex,
                                  count: _imagePaths.length,
                                  effect: const ExpandingDotsEffect(
                                    dotHeight: 4,
                                    dotWidth: 4,
                                    activeDotColor: AppColors.white,
                                    dotColor: AppColors.white,
                                    expansionFactor: 10,
                                    spacing: 4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 37,
                                        height: 37,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: AssetImage('assets/images/JaeseongGuri.png'),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Text('재성구리의 여행', style: AppTypography.body14SemiBold.copyWith(color: AppColors.neutral100),),
                                      ),
                                    ],
                                  ),
                                ),
                                Text('3명 구매', style: AppTypography.body14Medium.copyWith(color: AppColors.neutral60),),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(travelInfo['title'], style: AppTypography.subtitle18SemiBold,),
                                SizedBox(
                                  width: 110,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      AppSolidPngIcons.heart(size: 20, color: AppColors.orange60),
                                      const Text('5', style: AppTypography.body14Medium,),
                                      AppSolidPngIcons.star(size: 20, color: AppColors.warning40),
                                      const Text('4.8', style: AppTypography.body14Medium,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppOutlinePngIcons.calendar(),
                                  const Padding(padding: EdgeInsets.only(left: 10)),
                                  Text(
                                    '${travelInfo['startDay'].year}.${travelInfo['startDay'].month}.${travelInfo['startDay'].day} ~ ${travelInfo['endDay'].year}.${travelInfo['endDay'].month}.${travelInfo['endDay'].day}',
                                    style: AppTypography.caption12Medium.copyWith(color: AppColors.neutral100),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('₩ ${NumberFormat('#,###').format(travelInfo['price'])}', style: AppTypography.subtitle18Bold.copyWith(color: AppColors.neutral100),),
                              ),
                            ),
                            Container(
                              height: 152,
                              color: AppColors.neutral20,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Divider(
                                thickness: 1,
                                color: AppColors.neutral40,
                              ),
                            ),
                            Row(
                              children: [
                                const Text('1일 차',style: AppTypography.subtitle16SemiBold,),
                                const Padding(padding: EdgeInsets.only(left: 10)),
                                Text('${travelInfo['startDay'].month}월 ${travelInfo['startDay'].day}일',style: AppTypography.caption12Regular.copyWith(color: AppColors.neutral60),),
                              ],
                            ),
                            Column(
                              children: List.generate(travelSchedule[0].length, (scheduleIndex) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: ShapeDecoration(
                                                      shape: const CircleBorder(),
                                                      color: travelDailyColors[scheduleIndex%3],
                                                    ),
                                                    child: Center(child: Text('${scheduleIndex+1}', style: AppTypography.body16Medium.copyWith(color: AppColors.white),),),
                                                  ),
                                                  const Padding(padding: EdgeInsets.only(top: 10),),
                                                  Text('${travelSchedule[0][scheduleIndex]['time'].hour}:${travelSchedule[0][scheduleIndex]['time'].minute}', style: AppTypography.body14Medium.copyWith(color: AppColors.neutral100,),),
                                                ],
                                              )
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                                color: AppColors.neutral20,
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:[
                                                  Text(travelSchedule[0][scheduleIndex]['place'], style: AppTypography.body14Medium.copyWith(color: AppColors.neutral100),),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      AppOutlinePngIcons.locationMarker(size: 16, color: AppColors.neutral60,),
                                                      const Padding(padding: EdgeInsets.only(left: 6),),
                                                      Flexible(child: Text(travelSchedule[0][scheduleIndex]['address'], style: AppTypography.caption12Regular.copyWith(color: AppColors.neutral60),),),
                                                    ],
                                                  ),
                                                  if (travelSchedule[0][scheduleIndex]['price'] > 0) Text('₩ ${NumberFormat('#,###').format(travelSchedule[0][scheduleIndex]['price'])}', style: AppTypography.subtitle18Bold.copyWith(color: AppColors.indigo60),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (travelSchedule[0].length-1 != scheduleIndex) AppOutlinePngIcons.dotsVertical(size: 16, color: AppColors.neutral40),
                                  ],
                                );
                              }),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '테마 해시태그',
                                  style: AppTypography.subtitle16SemiBold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Container(
                              width: 350,
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(travelInfo['hashtag'].length, (hashtagIndex) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: AppColors.indigo60,
                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                    child: Text(
                                      '#${travelInfo['hashtag'][hashtagIndex]}',
                                      style: const TextStyle(color: AppColors.white),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 317,
                        height: 317,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            center: Alignment.center,
                            colors: [
                              AppColors.purple20,
                              AppColors.white,
                            ],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: Center(
                          child: Text('이어서 보려면 구매해야 해요', style: AppTypography.subtitle16SemiBold.copyWith(color: AppColors.neutral100),),
                        ),
                      )
                    ],
                  )
              ),
            ),
            SizedBox(
              height: 52,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: const LinearBorder(),
                  backgroundColor: AppColors.indigo60,
                ),
                onPressed: () => {},
                child: Text('구매', style: AppTypography.subtitle18SemiBold.copyWith(color: AppColors.white,),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommaFormatter extends TextInputFormatter {
  CommaFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final numberStr = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final int parsedInt = int.parse(numberStr);
    final formatter = NumberFormat.currency(locale: 'ko', symbol: '');
    String newText = formatter.format(parsedInt);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }
}
