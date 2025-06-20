import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'package:personalized_travel_recommendations/presentation/widgets/map_marker.dart';
import 'package:personalized_travel_recommendations/core/theme/app_colors.dart';
import 'package:personalized_travel_recommendations/core/theme/app_outline_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_solid_png_icons.dart';
import 'package:personalized_travel_recommendations/core/theme/app_text_styles.dart';

class TravelPackage extends StatefulWidget {
  final Map travelInfo;
  const TravelPackage({super.key, required this.travelInfo});

  @override
  State<TravelPackage> createState() => _TravelPackage();
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

  late GoogleMapController mapController;
  late LatLng _latlng = LatLng(35.6852, 139.6953);
  Set<Marker> _markers = {};

  static const List<List<Map>> travelSchedule = [
    [
      {
        'place':'티웨이항공 GMP 11:25 - TSA 13:10',
        'address':'인천국제공항 2터미널',
        'time':TimeOfDay(hour: 11, minute: 25),
        "lat": 0,
        "lng": 0,
      },
      {
        'place':'신주쿠 호텔',
        'address':'1-1 Maihama, Maihama, Urayasu',
        'time':TimeOfDay(hour: 13, minute: 50),
        "lat": 35.6852,
        "lng": 139.6953,
      },
      {
        'place':'신주쿠 공원',
        'address':'1-1 Maihama, Maihama, Urayasu 279-0031 Chiba Prefecture',
        'time':TimeOfDay(hour: 15, minute: 25),
        "lat": 35.6842,
        "lng": 139.7098,
      },
    ]
  ];

  List<Color> travelDailyColors = [
    AppColors.cyan20,
    AppColors.lime20,
    AppColors.purple20,
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _setMarkers() async {
    Set<Marker> newMarkers = {};
    LatLng newLatLng = _latlng;

    for (int scheduleIdx = 0; scheduleIdx < travelSchedule[0].length; scheduleIdx++) {
      if (travelSchedule[0][scheduleIdx]['lat'] != 0 && travelSchedule[0][scheduleIdx]['lng'] != 0) {
        newMarkers.add(
          Marker(
            markerId: MarkerId('0_${scheduleIdx}'),
            position: LatLng(travelSchedule[0][scheduleIdx]['lat'], travelSchedule[0][scheduleIdx]['lng']),
            infoWindow: InfoWindow(title: travelSchedule[0][scheduleIdx]['place']),
            icon: await MapMarker(text: (scheduleIdx+1).toString(), color: travelDailyColors[scheduleIdx%3],).toBitmapDescriptor(logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
          ),
        );

        newLatLng = LatLng(travelSchedule[0][scheduleIdx]['lat'], travelSchedule[0][scheduleIdx]['lng']);
      }
    }
    setState(() {
      _markers = newMarkers;
      _latlng = newLatLng;
    });

    _moveCamera();
  }

  void _moveCamera() {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _latlng,
          zoom: 14.0,
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 52,
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
                        margin: const EdgeInsets.only(left: 12),
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
                            height: 192,
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
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
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
                                      width: 36,
                                      height: 36,
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
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
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
                          SizedBox(
                            height: 160,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _latlng,
                                zoom: 16.0,
                              ),
                              myLocationEnabled: true,
                              zoomControlsEnabled: true,
                              markers: _markers,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Divider(
                              thickness: 1,
                              color: AppColors.neutral40,
                            ),
                          ),
                          Row(
                            children: [
                              const Text('1일 차',style: AppTypography.subtitle16SemiBold,),
                              const Padding(padding: EdgeInsets.only(left: 4)),
                              Text('${travelInfo['startDay'].month}월 ${travelInfo['startDay'].day}일',style: AppTypography.caption12Regular.copyWith(color: AppColors.neutral60),),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 12)),
                          Column(
                            children: List.generate(travelSchedule[0].length, (scheduleIndex) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
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
                                            const Padding(padding: EdgeInsets.only(top: 8),),
                                            Text('${travelSchedule[0][scheduleIndex]['time'].hour}:${travelSchedule[0][scheduleIndex]['time'].minute}', style: AppTypography.body14Medium.copyWith(color: AppColors.neutral100,),),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                            ),
                                            backgroundColor: AppColors.neutral20,
                                            shadowColor: Colors.transparent,
                                          ),
                                          onPressed: () => {
                                            setState(() {
                                              if (travelSchedule[0][scheduleIndex]['lat'] != 0 && travelSchedule[0][scheduleIndex]['lng'] != 0) {
                                                _latlng = LatLng(travelSchedule[0][scheduleIndex]['lat'],travelSchedule[0][scheduleIndex]['lng']);
                                              }
                                            }),
                                            _moveCamera()
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                              color: AppColors.neutral20,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  travelSchedule[0][scheduleIndex]['place'],
                                                  style: AppTypography.body14Medium.copyWith(color: AppColors.neutral100),
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    AppOutlinePngIcons.locationMarker(
                                                      size: 16,
                                                      color: AppColors.neutral60,
                                                    ),
                                                    const Padding(padding: EdgeInsets.only(left:4),),
                                                    Flexible(
                                                      child: Text(
                                                        travelSchedule[0][scheduleIndex]['address'],
                                                        style: AppTypography.caption12Regular.copyWith(color:AppColors.neutral60),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (travelSchedule[0].length-1 != scheduleIndex) AppOutlinePngIcons.dotsVertical(size: 16, color: AppColors.neutral40),
                                ],
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
                          Container(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(travelInfo['hashtag'].length, (hashtagIndex) {
                                return Container(
                                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
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
                      width: 316,
                      height: 316,
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
                ),
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
