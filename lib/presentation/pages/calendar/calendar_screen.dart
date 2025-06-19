import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/presentation/pages/calendar/add_travel_plan_continent_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/home/home_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/main_screen.dart';
import 'package:personalized_travel_recommendations/presentation/pages/calendar/edit_travel_plan_schedule_screen.dart';

class TravelCalendarScreen extends StatefulWidget {
  final bool isLoggedIn;
  const TravelCalendarScreen({super.key, this.isLoggedIn = false});

  @override
  State<TravelCalendarScreen> createState() => _TravelCalendarScreenState();
}

class _TravelCalendarScreenState extends State<TravelCalendarScreen> {
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.isLoggedIn;
  }

  static List<Map> travelList = [
    {
      'title': '도쿄 10대 맛집 뿌수기',
      'startDay': DateTime.utc(2025, 3, 18),
      'endDay': DateTime.utc(2025, 3, 20),
      'period': 3,
      'country': '일본',
      'city': '도쿄',
      'hashtag': [
        '친구와',
        '1개 도시',
        '맛집 투어',
      ],
    },
    {
      'title': '여수 밤바다',
      'startDay': DateTime.utc(2025, 6, 1),
      'endDay': DateTime.utc(2025, 6, 2),
      'period': 2,
      'country': '대한민국',
      'city': '여수',
      'hashtag': [
        '친구와',
        '1개 도시',
        '맛집 투어',
      ],
    },
    {
      'title': '제주도의 푸른 밤',
      'startDay': DateTime.utc(2025, 6, 6),
      'endDay': DateTime.utc(2025, 6, 8),
      'period': 3,
      'country': '대한민국',
      'city': '여수',
      'hashtag': [
        '친구와',
        '1개 도시',
        '맛집 투어',
      ],
    },
  ];

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  final List<DateTimeRange> _ranges = List.generate(travelList.length, (index) {
    return DateTimeRange(
      start: travelList[index]['startDay'],
      end: travelList[index]['endDay'],
    );
  });

  bool _isStart(DateTime day) {
    return _ranges.any((range) => day.isAtSameMomentAs(range.start));
  }

  bool _isEnd(DateTime day) {
    return _ranges.any((range) => day.isAtSameMomentAs(range.end));
  }

  bool _isInAnyRange(DateTime day) {
    return _ranges.any((range) =>
        day.isAtSameMomentAs(range.start) ||
        day.isAtSameMomentAs(range.end) ||
        (day.isAfter(range.start) && day.isBefore(range.end)));
  }

  bool _isInRange(DateTime day, DateTime startDay, DateTime endDay) {
    return day.isAtSameMomentAs(startDay) ||
        day.isAtSameMomentAs(endDay) ||
        (day.isAfter(startDay) && day.isBefore(endDay));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '나의 여행 캘린더',
              style: AppTypography.subtitle20Bold,
            ),
            IconButton(
              onPressed: () async {
                if (!isLoggedIn) {
                  final result = await LoginRequiredDialog.show(context);
                  if (result == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(
                            initialIndex: 2, isLoggedIn: false
                        ),
                      ),
                    );
                  }
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTravelPlanContinentScreen(),
                  ),
                );
              },
              icon: AppOutlinePngIcons.plus(),
            ),
          ],
        ),
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 324,
              decoration: const BoxDecoration(
                  color: AppColors.neutral10,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TableCalendar(
                shouldFillViewport: true,
                locale: "ko-KR",
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  return isSameDay(selectedDay, day);
                },
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  formatButtonShowsNext: false,
                  titleTextStyle: AppTypography.subtitle16SemiBold.copyWith(color: AppColors.neutral100),
                  leftChevronIcon: AppOutlinePngIcons.chevronDoubleLeft(),
                  rightChevronIcon: AppOutlinePngIcons.chevronDoubleRight(),
                ),
                calendarStyle: CalendarStyle(
                  defaultDecoration: const BoxDecoration(),
                  outsideDecoration: const BoxDecoration(),
                  todayTextStyle: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                  defaultTextStyle: AppTypography.caption12Medium.copyWith(color: AppColors.neutral100),
                  weekendTextStyle: AppTypography.caption12Medium.copyWith(color: AppColors.neutral100),
                  outsideTextStyle: AppTypography.caption12Medium.copyWith(color: AppColors.neutral40),
                ),
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, day, focusedDay) {
                    if (_isStart(day)) {
                      return Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 36,
                                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.indigo60,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.neutral40,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${day.day}',
                                style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (_isEnd(day)) {
                      return Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 36,
                                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.indigo60,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.neutral40,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${day.day}',
                                style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (_isInAnyRange(day)) {
                      return Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 36,
                                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.indigo60,
                                  shape: BoxShape.rectangle,
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.neutral40,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${day.day}',
                                style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.neutral40,
                        ),
                        child: Text(
                          '${day.day}',
                          style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    if (_isStart(day)) {
                      return Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 36,
                                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.indigo60,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.indigo20,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${day.day}',
                                style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (_isEnd(day)) {
                      return Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 36,
                                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.indigo60,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.indigo20,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${day.day}',
                                style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (_isInAnyRange(day)) {
                      return Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 36,
                                margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.indigo60,
                                  shape: BoxShape.rectangle,
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.indigo20,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${day.day}',
                                style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        width: 32,
                        height: 32,
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.indigo20,
                        ),
                        child: Text(
                          '${day.day}',
                          style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                        ),
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    if (_isStart(day)) {
                      return Center(
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.indigo60,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            '${day.day}',
                            style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                          ),
                        ),
                      );
                    } else if (_isEnd(day)) {
                      return Center(
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.indigo60,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            '${day.day}',
                            style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                          ),
                        ),
                      );
                    } else if (_isInAnyRange(day)) {
                      return Center(
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.indigo60,
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            '${day.day}',
                            style: AppTypography.caption12Medium.copyWith(color: AppColors.white),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: AppTypography.caption12Medium.copyWith(color: AppColors.neutral100),
                        ),
                      ),
                    );
                  },
                ),
                rangeSelectionMode: RangeSelectionMode.toggledOff,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: const Text(
                "나의 이전 여행",
                style: AppTypography.subtitle16SemiBold,
                textAlign: TextAlign.left,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  ...List.generate(travelList.length, (travelIndex) {
                    return _isInRange(selectedDay, travelList[travelIndex]['startDay'], travelList[travelIndex]['endDay']) ?
                      Column(
                        children: [
                          Row(
                            children: [
                              AppOutlinePngIcons.calendar(size: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '${DateFormat('yyyy.MM.dd').format(travelList[travelIndex]['startDay'])} ~ ${DateFormat('yyyy.MM.dd').format(travelList[travelIndex]['endDay'])}',
                                  style: AppTypography.caption12Medium,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            decoration: const BoxDecoration(
                              color: AppColors.neutral20,
                              borderRadius:
                                BorderRadius.all(Radius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 75,
                                        decoration: const BoxDecoration(
                                          color: AppColors.neutral70,
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/TokyoRestaurants.png'),
                                          ),
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.only(right: 12)),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              travelList[travelIndex]['title'],
                                              style: AppTypography.subtitle18SemiBold,
                                            ),
                                            Text(
                                              '${travelList[travelIndex]['country']} ${travelList[travelIndex]['city']}',
                                              style: AppTypography.caption12Medium.copyWith(color: AppColors.neutral50),
                                            ),
                                            const Padding(padding: EdgeInsets.all(4)),
                                            Text(
                                              '${travelList[travelIndex]['period'] - 1}박 ${travelList[travelIndex]['period']}일',
                                              style: AppTypography.body14SemiBold.copyWith(color: AppColors.indigo40),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        style: IconButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditTravelPlanScheduleScreen(country: travelList[travelIndex]['country'], city: travelList[travelIndex]['city']),
                                            ),
                                          );
                                        },
                                        icon: AppOutlinePngIcons.chevronDoubleRight(),
                                      ),
                                    ],
                                  ),
                                  const Padding(padding: EdgeInsets.only(top: 16),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: List.generate(travelList[travelIndex]['hashtag'].length, (hashtagIndex) {
                                      return Container(
                                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                        decoration: const BoxDecoration(
                                          color: AppColors.indigo60,
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Text(
                                          '#${travelList[travelIndex]['hashtag'][hashtagIndex]}',
                                          style: AppTypography.body14Medium.copyWith(color: AppColors.white),
                                        ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                      : Container();
                  }),
                  if (!_isInAnyRange(selectedDay))
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        color: AppColors.neutral20,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: Text(
                          '해당 일자에 등록된 여행이 없습니다.',
                          style: AppTypography.subtitle16SemiBold.copyWith(color: AppColors.neutral100),
                        ),
                      ),
                    ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
