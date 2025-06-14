import '../../../data/datasources/travel_packages_data_source.dart';
import '../../../data/models/travel_package_model.dart';
import '../../../presentation/utils/category_filter_helper.dart';

class TravelPackagesUseCase {
  static List<TravelPackageModel> getAllPackages() {
    return TravelPackagesDataSource.getAllPackages()
        .map((data) => TravelPackageModel.fromMap(data))
        .toList();
  }

  static List<TravelPackageModel> getPackagesByCategory(String category) {
    return TravelPackagesDataSource.getPackagesByCategory(category)
        .map((data) => TravelPackageModel.fromMap(data))
        .toList();
  }

  static List<String> getCategories() {
    return TravelPackagesDataSource.getCategories();
  }

  static List<Map<String, dynamic>> getCategoryFilters() {
    return CategoryFilterHelper.createCategoryFilters(getCategories());
  }
} 