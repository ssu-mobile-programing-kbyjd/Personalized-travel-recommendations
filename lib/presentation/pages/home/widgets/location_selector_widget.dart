import 'package:flutter/material.dart';
import 'package:personalized_travel_recommendations/domain/usecases/location_usecase.dart';
import 'package:personalized_travel_recommendations/domain/entities/location_entity.dart';

class LocationSelectorWidget extends StatefulWidget {
  final LocationEntity? initialLocation;
  final Function(LocationEntity) onLocationChanged;

  const LocationSelectorWidget({
    super.key,
    this.initialLocation,
    required this.onLocationChanged,
  });

  @override
  State<LocationSelectorWidget> createState() => _LocationSelectorWidgetState();
}

class _LocationSelectorWidgetState extends State<LocationSelectorWidget> {
  final LocationUseCase _locationUseCase = LocationUseCase();
  
  String? _selectedContinent;
  String? _selectedCountry;
  String? _selectedCity;
  int _locationStep = 0; // 0: 초기상태, 1: 대륙선택, 2: 국가선택, 3: 도시선택, 4: 완료

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _selectedContinent = widget.initialLocation!.continent;
      _selectedCountry = widget.initialLocation!.country;
      _selectedCity = widget.initialLocation!.city;
      _locationStep = 4;
    } else {
      // 기본값 설정
      _selectedContinent = '아시아';
      _selectedCountry = '대한민국';
      _selectedCity = '서울';
      _locationStep = 4;
      // 빌드가 완료된 후에 콜백 호출
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _notifyLocationChanged();
      });
    }
  }

  void _notifyLocationChanged() {
    if (_selectedContinent != null && _selectedCountry != null && _selectedCity != null) {
      final location = _locationUseCase.createLocation(
        _selectedContinent!,
        _selectedCountry!,
        _selectedCity!,
      );
      widget.onLocationChanged(location);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_locationStep) {
      case 0:
        return _buildLocationButton();
      case 1:
        return _buildContinentSelector();
      case 2:
        return _buildCountrySelector();
      case 3:
        return _buildCitySelector();
      case 4:
      default:
        return _buildSelectedLocation();
    }
  }

  Widget _buildLocationButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _locationStep = 1;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F4F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              '위치 선택',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4032DC),
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF4032DC),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinentSelector() {
    final continents = _locationUseCase.getContinents();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '대륙을 선택하세요',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...continents.map((continent) => ListTile(
            title: Text(continent),
            onTap: () {
              setState(() {
                _selectedContinent = continent;
                _locationStep = 2;
              });
            },
          )),
          TextButton(
            onPressed: () {
              setState(() {
                _locationStep = 0;
              });
            },
            child: const Text('취소'),
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySelector() {
    final countries = _locationUseCase.getCountries(_selectedContinent!);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$_selectedContinent의 국가를 선택하세요',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...countries.map((country) => ListTile(
            title: Text(country),
            onTap: () {
              setState(() {
                _selectedCountry = country;
                _locationStep = 3;
              });
            },
          )),
          TextButton(
            onPressed: () {
              setState(() {
                _locationStep = 1;
              });
            },
            child: const Text('뒤로'),
          ),
        ],
      ),
    );
  }

  Widget _buildCitySelector() {
    final cities = _locationUseCase.getCities(_selectedContinent!, _selectedCountry!);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$_selectedCountry의 도시를 선택하세요',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...cities.map((city) => ListTile(
            title: Text(city),
            onTap: () {
              setState(() {
                _selectedCity = city;
                _locationStep = 4;
                _notifyLocationChanged();
              });
            },
          )),
          TextButton(
            onPressed: () {
              setState(() {
                _locationStep = 2;
              });
            },
            child: const Text('뒤로'),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedLocation() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _locationStep = 1;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F4F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_selectedCity, $_selectedCountry',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4032DC),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF4032DC),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
} 