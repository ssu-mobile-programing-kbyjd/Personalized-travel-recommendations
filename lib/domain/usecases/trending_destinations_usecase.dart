import '../../data/datasources/trending_destinations_data_source.dart';
import '../../data/models/trending_destination_model.dart';

class TrendingDestinationsUseCase {
  List<String> getCategories() {
    return TrendingDestinationsDataSource.categories;
  }

  List<TrendingDestinationModel> getDestinationsByCategoryIndex(int index) {
    final categories = getCategories();
    if (index < 0 || index >= categories.length) return [];
    return TrendingDestinationsDataSource.getDestinationsByCategory(categories[index]);
  }
} 