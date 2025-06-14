import 'package:flutter/material.dart';

class CategoryFilterWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CategoryFilterWidget({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 37,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == selectedIndex;
          
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              margin: EdgeInsets.only(right: index < categories.length - 1 ? 16 : 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4032DC) : const Color(0xFFF1F4F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCategoryIcon(category['icon'] as String, isSelected),
                  const SizedBox(width: 8),
                  Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryIcon(String iconName, bool isSelected) {
    IconData iconData;
    
    switch (iconName) {
      case 'Icons.house_outlined':
        iconData = Icons.house_outlined;
        break;
      case 'Icons.apartment_outlined':
        iconData = Icons.apartment_outlined;
        break;
      case 'Icons.business_outlined':
        iconData = Icons.business_outlined;
        break;
      case 'Icons.home_outlined':
        iconData = Icons.home_outlined;
        break;
      case 'Icons.location_city_outlined':
        iconData = Icons.location_city_outlined;
        break;
      default:
        iconData = Icons.place_outlined;
    }

    return Icon(
      iconData,
      size: 20,
      color: isSelected ? Colors.white : const Color(0xFF64748B),
    );
  }
} 