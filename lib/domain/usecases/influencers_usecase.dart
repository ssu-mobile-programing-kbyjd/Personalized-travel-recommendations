import '../../data/datasources/influencers_data_source.dart';
import '../../data/models/influencer_model.dart';

class InfluencersUseCase {
  List<String> getCategories() {
    return InfluencersDataSource.categories;
  }

  List<InfluencerModel> getInfluencersByCategoryIndex(int index) {
    final categories = getCategories();
    if (index < 0 || index >= categories.length) return [];
    return InfluencersDataSource.getInfluencersByCategory(categories[index]);
  }
} 