import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';
import 'package:personalized_travel_recommendations/core/utils/utils/text_formatters.dart'
    as formatters;
import 'package:personalized_travel_recommendations/data/datasources/travel_data.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/map_marker.dart';
import 'package:personalized_travel_recommendations/presentation/pages/calendar/organize_travel_packages.dart';

class EditTravelPlanScheduleScreen extends StatefulWidget {
  final Map travelInfo;
  const EditTravelPlanScheduleScreen({super.key, required this.travelInfo});

  @override
  State<EditTravelPlanScheduleScreen> createState() =>
      _EditTravelPlanScheduleScreen();
}

class _EditTravelPlanScheduleScreen
    extends State<EditTravelPlanScheduleScreen> {
  late Map travelInfo = widget.travelInfo;
  static const userId = 'user_123';

  TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();

  String _infoEditButtonText = '수정';
  bool _isInfoEdit = false;

  String _titleEditButtonText = '편집';
  bool _isReadOnlyTitleEdit = true;

  late GoogleMapController mapController;
  late LatLng _latlng = LatLng(TravelData.cityLatLng[travelInfo['city']]![0],
      TravelData.cityLatLng[travelInfo['city']]![1]);
  Set<Marker> _markers = {};

  // 'place':<String>,
  // 'address':<String>,
  // 'time':<TimeOfDay(hour: 00, minute: 00)>,
  // 'lat' : <double>
  // 'lng' : <double>
  List<List<Map>> travelSchedule = [[]];

  List<Color> travelDailyColors = [
    AppColors.cyan20,
    AppColors.lime20,
    AppColors.purple20,
  ];

  final List<TextEditingController> _hashtagController = [];
  bool _isRelease = true;

  TextEditingController _priceController = TextEditingController();

  void _editInfo() async {
    if (_infoEditButtonText == '수정') {
      setState(() {
        _infoEditButtonText = '완료';
        _isInfoEdit = true;
      });
    } else {
      setState(() {
        _infoEditButtonText = '수정';
        _isInfoEdit = false;
      });

      await _updateInfo();
      await _delteSchedule();
      await _setSchedule();
    }
  }

  void _editTitle() {
    setState(() {
      if (_titleEditButtonText == '확인') {
        _titleFocus.unfocus();
        _titleEditButtonText = '편집';
        _isReadOnlyTitleEdit = true;
        travelInfo['title'] = _titleController.text;
      } else {
        FocusScope.of(context).requestFocus(_titleFocus);
        _titleEditButtonText = '확인';
        _isReadOnlyTitleEdit = false;
      }
    });
  }

  Future<void> _updateInfo() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('trips');
    final snapshot =
        await ref.where('tripId', isEqualTo: travelInfo['tripId']).get();

    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        await ref.doc(doc.id).update({
          'title': travelInfo['title'],
          'startDay': travelInfo['startDay'],
          'endDay': travelInfo['endDay'],
          'period': travelInfo['period'],
          'hashtag': travelInfo['hashtag'],
          'price': travelInfo['price'],
        });
      }
    }
  }

  Future<void> _getSchedule() async {
    travelSchedule.clear();
    for (int i = 0; i < travelInfo['period']; i++) {
      travelSchedule.add([]);
    }

    CollectionReference ref =
        FirebaseFirestore.instance.collection('schedules');
    final snapshot =
        await ref.where('tripId', isEqualTo: travelInfo['tripId']).get();
    final allDocs =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    allDocs.sort((a, b) {
      int dayCompare = (a['dayCount'] as int).compareTo(b['dayCount'] as int);
      if (dayCompare != 0) return dayCompare;

      return (a['scheduleIdx'] as int).compareTo(b['scheduleIdx'] as int);
    });

    for (var doc in allDocs) {
      int dayCount = doc['dayCount'];

      setState(() {
        travelSchedule[dayCount].add({
          'place': doc['place'],
          'address': doc['address'],
          'time': TimeOfDay(hour: doc['hour'], minute: doc['minute']),
          'lat': doc['lat'],
          'lng': doc['lng'],
        });
      });

      // _sortSchedulesByTime(dayCount);
    }

    _setMarkers();
  }

  Future<void> _setSchedule() async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('schedules');

    for (int periodIdx = 0; periodIdx < travelInfo['period']; periodIdx++) {
      for (int scheduleIdx = 0;
          scheduleIdx < travelSchedule[periodIdx].length;
          scheduleIdx++) {
        await ref.doc().set({
          'tripId': travelInfo['tripId'],
          'dayCount': periodIdx,
          'scheduleIdx': scheduleIdx,
          'place': travelSchedule[periodIdx][scheduleIdx]['place'],
          'address': travelSchedule[periodIdx][scheduleIdx]['address'],
          'hour': travelSchedule[periodIdx][scheduleIdx]['time'].hour,
          'minute': travelSchedule[periodIdx][scheduleIdx]['time'].minute,
          'lat': travelSchedule[periodIdx][scheduleIdx]['lat'],
          'lng': travelSchedule[periodIdx][scheduleIdx]['lng'],
        });
      }
    }
  }

  Future<void> _delteSchedule() async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('schedules');
    final snapshot =
        await ref.where('tripId', isEqualTo: travelInfo['tripId']).get();

    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        await ref.doc(doc.id).delete();
      }
    }
  }

  void _setDate(int knd) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.utc(2025, 1, 1),
      lastDate: DateTime.utc(2025, 12, 31),
      initialDate: knd == 0 ? travelInfo['startDay'] : travelInfo['endDay'],
    );
    if (dateTime != null) {
      setState(() {
        if (knd == 0) {
          travelInfo['startDay'] = dateTime;
          if (travelInfo['startDay'].isAfter(travelInfo['endDay'])) {
            travelInfo['endDay'] = dateTime;
          }
        } else {
          travelInfo['endDay'] = dateTime;
          if (travelInfo['endDay'].isBefore(travelInfo['startDay'])) {
            travelInfo['startDay'] = dateTime;
          }
        }

        travelInfo['period'] =
            travelInfo['endDay'].difference(travelInfo['startDay']).inDays + 1;

        travelSchedule.clear();
        for (int i = 0; i < travelInfo['period']; i++) {
          travelSchedule.add([]);
        }
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _setMarkers() async {
    Set<Marker> newMarkers = {};
    LatLng newLatLng = _latlng;

    for (int periodIdx = 0; periodIdx < travelInfo['period']; periodIdx++) {
      for (int scheduleIdx = 0;
          scheduleIdx < travelSchedule[periodIdx].length;
          scheduleIdx++) {
        if (travelSchedule[periodIdx][scheduleIdx]['lat'] != 0 &&
            travelSchedule[periodIdx][scheduleIdx]['lng'] != 0) {
          newMarkers.add(
            Marker(
              markerId: MarkerId('${periodIdx}_${scheduleIdx}'),
              position: LatLng(travelSchedule[periodIdx][scheduleIdx]['lat'],
                  travelSchedule[periodIdx][scheduleIdx]['lng']),
              infoWindow: InfoWindow(
                  title: travelSchedule[periodIdx][scheduleIdx]['place']),
              icon: await MapMarker(
                text: (scheduleIdx + 1).toString(),
                color: travelDailyColors[periodIdx % 3],
              ).toBitmapDescriptor(
                  logicalSize: const Size(150, 150),
                  imageSize: const Size(150, 150)),
            ),
          );

          newLatLng = LatLng(travelSchedule[periodIdx][scheduleIdx]['lat'],
              travelSchedule[periodIdx][scheduleIdx]['lng']);
        }
      }
    }

    setState(() {
      _markers = newMarkers;
      _latlng = newLatLng;
    });

    // _moveCamera();
  }

  void _moveCamera() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _latlng,
          zoom: 14.0,
        ),
      ),
    );
  }

  void _removeSchedule(int travelIndex, int scheduleIndex) {
    setState(() {
      travelSchedule[travelIndex].removeAt(scheduleIndex);
      _setMarkers();
    });
  }

  void _selectTime(int travelIndex, int scheduleIndex) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: travelSchedule[travelIndex][scheduleIndex]['time'],
    );

    if (selectedTime != null) {
      setState(() {
        travelSchedule[travelIndex][scheduleIndex]['time'] = selectedTime;

        // 시간 순서대로 정렬
        _sortSchedulesByTime(travelIndex);
      });
    }
  }

  void _sortSchedulesByTime(int travelIndex) {
    travelSchedule[travelIndex].sort((a, b) {
      final TimeOfDay timeA = a['time'];
      final TimeOfDay timeB = b['time'];

      // TimeOfDay를 분으로 변환하여 비교
      final minutesA = timeA.hour * 60 + timeA.minute;
      final minutesB = timeB.hour * 60 + timeB.minute;

      return minutesA.compareTo(minutesB);
    });
  }

  void _setHashtag() {
    for (var hashtag in travelInfo['hashtag']) {
      setState(() {
        _hashtagController.add(TextEditingController(text: "#" + hashtag));
      });
    }
  }

  void _addHashtag() {
    setState(() {
      _hashtagController.add(TextEditingController(text: '#'));
      travelInfo['hashtag'].add('');
    });
  }

  void _removeHashtag(int index) {
    setState(() {
      travelInfo['hashtag'].removeAt(index);
      _hashtagController.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: travelInfo['title']);
    _priceController = TextEditingController(text: '₩${travelInfo['price']}');

    _getSchedule();
    _setMarkers();
    _setHashtag();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 52,
              // margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              decoration: const BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 2.0, color: AppColors.neutral20),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 64,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 12),
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
                          child: AppOutlinePngIcons.arrowNarrowLeft(
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "여행 추가",
                    style: AppTypography.subtitle16SemiBold
                        .copyWith(color: AppColors.neutral100),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: _editInfo,
                    child: Container(
                      width: 64,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      child: Text(
                        _infoEditButtonText,
                        style: AppTypography.subtitle16SemiBold
                            .copyWith(color: AppColors.indigo60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: TextField(
                              controller: _titleController,
                              readOnly: _isReadOnlyTitleEdit,
                              focusNode: _titleFocus,
                              decoration: const InputDecoration(
                                hintText: '제목을 입력하세요',
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.neutral40,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              style: _titleFocus.hasFocus
                                  ? AppTypography.body14Medium
                                  : AppTypography.subtitle18SemiBold,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: _isInfoEdit ? _editTitle : null,
                            child: Text(
                              _titleEditButtonText,
                              style: AppTypography.body14Medium
                                  .copyWith(color: AppColors.neutral100),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AppOutlinePngIcons.calendar(),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: _isInfoEdit ? () => _setDate(0) : null,
                            child: Text(
                              // '${startDay.year}.${startDay.month}.${startDay.day}',
                              '${travelInfo['startDay'].year}.${travelInfo['startDay'].month}.${travelInfo['startDay'].day}',
                              style: AppTypography.caption12Medium
                                  .copyWith(color: AppColors.neutral100),
                            ),
                          ),
                          Text(
                            ' ~ ',
                            style: AppTypography.caption12Medium
                                .copyWith(color: AppColors.neutral100),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: _isInfoEdit ? () => _setDate(1) : null,
                            child: Text(
                              // '${endDay.year}.${endDay.month}.${endDay.day}',
                              '${travelInfo['endDay'].year}.${travelInfo['endDay'].month}.${travelInfo['endDay'].day}',
                              style: AppTypography.caption12Medium
                                  .copyWith(color: AppColors.neutral100),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 160,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _latlng,
                            zoom: 14.0,
                          ),
                          myLocationEnabled: true,
                          zoomControlsEnabled: true,
                          markers: _markers,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                        child: Divider(
                          thickness: 1,
                          color: AppColors.neutral40,
                        ),
                      ),
                      Column(
                        children:
                            List.generate(travelInfo['period'], (periodIndex) {
                          return ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            child: ExpansionTile(
                              shape: const Border(),
                              controlAffinity: ListTileControlAffinity.leading,
                              expandedAlignment: Alignment.topLeft,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${periodIndex + 1}일 차',
                                        style: AppTypography.subtitle16SemiBold,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Text(
                                        '${travelInfo['startDay'].add(Duration(days: periodIndex)).month}월 ${travelInfo['startDay'].add(Duration(days: periodIndex)).day}일',
                                        style: AppTypography.caption12Regular
                                            .copyWith(
                                                color: AppColors.neutral60),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: _isInfoEdit
                                        ? () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrganizeTravelPackagesScreen(
                                                  dayIndex: periodIndex,
                                                  travelSchedule:
                                                      travelSchedule,
                                                  selectedCity: travelInfo[
                                                              'city'] ==
                                                          '자유'
                                                      ? '자유 여행'
                                                      : travelInfo[
                                                          'city'], // 자유여행이거나 선택된 도시/나라/대륙 전달
                                                  selectedCountry: travelInfo[
                                                      'country'], // 선택된 국가 전달
                                                  selectedContinent:
                                                      null, // 대륙 정보는 현재 없으므로 null
                                                ),
                                              ),
                                            );
                                            // 선택된 패키지 데이터를 일정에 추가
                                            if (result != null) {
                                              setState(() {
                                                travelSchedule[periodIndex]
                                                    .add(result);
                                                if (result['lat'] != 0 &&
                                                    result['lng'] != 0) {
                                                  _latlng = LatLng(
                                                      result['lat'],
                                                      result['lng']);
                                                }
                                              });
                                              _setMarkers();
                                              _moveCamera();
                                            }
                                          }
                                        : null,
                                    icon: AppOutlinePngIcons.plus(
                                        color: _isInfoEdit
                                            ? AppColors.neutral100
                                            : AppColors.neutral40),
                                  ),
                                ],
                              ),
                              children: [
                                ...List.generate(
                                    travelSchedule[periodIndex].length,
                                    (scheduleIndex) {
                                  return Column(
                                    key: ValueKey(
                                        '${periodIndex}_$scheduleIndex'),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: ShapeDecoration(
                                                    shape: const CircleBorder(),
                                                    color: travelDailyColors[
                                                        periodIndex % 3],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${scheduleIndex + 1}',
                                                      style: AppTypography
                                                          .body16Medium
                                                          .copyWith(
                                                              color: AppColors
                                                                  .white),
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                ),
                                                GestureDetector(
                                                  onTap: _isInfoEdit
                                                      ? () => _selectTime(
                                                          periodIndex,
                                                          scheduleIndex)
                                                      : null,
                                                  child: Text(
                                                    '${travelSchedule[periodIndex][scheduleIndex]['time'].hour.toString().padLeft(2, '0')}:${travelSchedule[periodIndex][scheduleIndex]['time'].minute.toString().padLeft(2, '0')}',
                                                    style: AppTypography
                                                        .body14Medium
                                                        .copyWith(
                                                      color:
                                                          AppColors.neutral100,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                                backgroundColor:
                                                    AppColors.neutral20,
                                                shadowColor: Colors.transparent,
                                              ),
                                              onPressed: () => {
                                                setState(() {
                                                  if (travelSchedule[periodIndex]
                                                                  [scheduleIndex]
                                                              ['lat'] !=
                                                          0 &&
                                                      travelSchedule[periodIndex]
                                                                  [
                                                                  scheduleIndex]
                                                              ['lng'] !=
                                                          0) {
                                                    _latlng = LatLng(
                                                        travelSchedule[
                                                                    periodIndex]
                                                                [scheduleIndex]
                                                            ['lat'],
                                                        travelSchedule[
                                                                    periodIndex]
                                                                [scheduleIndex]
                                                            ['lng']);
                                                  }
                                                }),
                                                _moveCamera()
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        32, 16, 32, 16),
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      color:
                                                          AppColors.neutral20,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          travelSchedule[
                                                                      periodIndex]
                                                                  [
                                                                  scheduleIndex]
                                                              ['place'],
                                                          style: AppTypography
                                                              .body14Medium
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .neutral100),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            AppOutlinePngIcons
                                                                .locationMarker(
                                                              size: 16,
                                                              color: AppColors
                                                                  .neutral60,
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 4),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                travelSchedule[
                                                                            periodIndex]
                                                                        [
                                                                        scheduleIndex]
                                                                    ['address'],
                                                                style: AppTypography
                                                                    .caption12Regular
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .neutral60),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (_isInfoEdit)
                                                    Positioned(
                                                      top: -12,
                                                      right: -8,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            _removeSchedule(
                                                                periodIndex,
                                                                scheduleIndex),
                                                        icon: AppOutlinePngIcons
                                                            .x(
                                                          color: AppColors
                                                              .neutral80,
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (travelSchedule[periodIndex].length -
                                              1 !=
                                          scheduleIndex)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 4),
                                          child:
                                              AppOutlinePngIcons.dotsVertical(
                                                  size: 16,
                                                  color: AppColors.neutral40),
                                        ),
                                    ],
                                  );
                                }),
                                if (travelSchedule[periodIndex].isEmpty)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: ShapeDecoration(
                                              shape: const CircleBorder(),
                                              color: travelDailyColors[
                                                  periodIndex % 3]),
                                          child: Center(
                                            child: Text(
                                              '1',
                                              style: AppTypography.body16Medium
                                                  .copyWith(
                                                      color: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              32, 24, 32, 24),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: AppColors.neutral20,
                                          ),
                                          child: const Text(
                                            '일정을 추가해주세요.',
                                            style: AppTypography.body14Medium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '테마 해시태그',
                            style: AppTypography.subtitle16SemiBold,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '최대 3개까지 선택 가능합니다.',
                            style: AppTypography.caption12Regular,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.neutral20,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...List.generate(travelInfo['hashtag'].length,
                                (index) {
                              return SizedBox(
                                width: 114,
                                height: 48,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 108,
                                        height: 48,
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 8, 12, 8),
                                        decoration: const BoxDecoration(
                                          color: AppColors.indigo60,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            controller:
                                                _hashtagController[index],
                                            readOnly: !_isInfoEdit,
                                            maxLength: 6,
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              formatters.PrefixInputFormatter(
                                                  '#')
                                            ],
                                            style: AppTypography.body14SemiBold
                                                .copyWith(
                                                    color: AppColors.white),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 8),
                                            ),
                                            onEditingComplete: () => {
                                              setState(() {
                                                travelInfo['hashtag'][index] =
                                                    _hashtagController[index]
                                                        .text
                                                        .replaceFirst('#', '');
                                              }),
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_isInfoEdit)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: SizedBox(
                                          width: 12,
                                          height: 12,
                                          child: IconButton(
                                            style: IconButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(0),
                                              backgroundColor: AppColors.white,
                                              disabledBackgroundColor:
                                                  AppColors.white,
                                            ),
                                            onPressed: () =>
                                                _removeHashtag(index),
                                            icon: AppOutlinePngIcons.x(
                                              color: AppColors.neutral80,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                            if (travelInfo['hashtag'].length < 3 && _isInfoEdit)
                              SizedBox(
                                width: 28,
                                height: 28,
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor: AppColors.white,
                                    disabledBackgroundColor: AppColors.white,
                                  ),
                                  onPressed: _addHashtag, // _isRelease 조건 제거
                                  icon: AppOutlinePngIcons.plus(
                                    color: AppColors.neutral80,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 24,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '패키지 공개 / 비공개',
                            style: AppTypography.subtitle16SemiBold,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: RadioListTile(
                              title: const Text(
                                '공개',
                                style: AppTypography.body14Regular,
                              ),
                              value: true,
                              groupValue: _isRelease,
                              onChanged: _isInfoEdit
                                  ? (bool? value) {
                                      setState(() {
                                        _isRelease = value!;
                                      });
                                    }
                                  : null,
                              activeColor: AppColors.indigo60,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: RadioListTile(
                              title: const Text(
                                '비공개',
                                style: AppTypography.body14Regular,
                              ),
                              value: false,
                              groupValue: _isRelease,
                              onChanged: _isInfoEdit
                                  ? (bool? value) {
                                      setState(() {
                                        _isRelease = value!;
                                      });
                                    }
                                  : null,
                              activeColor: AppColors.indigo60,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 24,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '판매 금액',
                            style: AppTypography.subtitle16SemiBold,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: TextField(
                          controller: _priceController,
                          enabled: (_isInfoEdit && _isRelease),
                          style: AppTypography.body16Medium.copyWith(
                            color: (_isInfoEdit && _isRelease)
                                ? AppColors.neutral100
                                : AppColors.neutral40,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _isRelease
                                    ? AppColors.neutral40
                                    : AppColors.neutral20,
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _isRelease
                                    ? AppColors.neutral40
                                    : AppColors.neutral20,
                                width: 0.5,
                              ),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.neutral20,
                                width: 0.5,
                              ),
                            ),
                            fillColor: _isRelease
                                ? AppColors.white
                                : AppColors.neutral10,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            formatters.CommaFormatter(),
                            formatters.PrefixInputFormatter('₩'),
                          ],
                          onEditingComplete: () => {
                            if (_isRelease)
                              {
                                setState(() {
                                  travelInfo['price'] = double.parse(
                                      _priceController.text
                                          .replaceFirst('₩', ''));
                                }),
                              }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
