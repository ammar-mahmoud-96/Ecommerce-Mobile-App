import '../models/home_model.dart';

/// Abstract class for remote data source
abstract class HomeRemoteDataSource {
  /// Get all home items from remote
  Future<List<HomeModel>> getHomeItems();

  /// Get a single home item by ID from remote
  Future<HomeModel> getHomeItem(String id);

  /// Create a new home item on remote
  Future<HomeModel> createHomeItem(HomeModel model);

  /// Update an existing home item on remote
  Future<HomeModel> updateHomeItem(HomeModel model);

  /// Delete a home item from remote
  Future<void> deleteHomeItem(String id);
}

/// Implementation of HomeRemoteDataSource
/// Replace with actual API implementation
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  // final http.Client client;
  // HomeRemoteDataSourceImpl(this.client);

  @override
  Future<List<HomeModel>> getHomeItems() async {
    // TODO: Implement actual API call
    // Example:
    // final response = await client.get(Uri.parse('$baseUrl/items'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonList = json.decode(response.body);
    //   return jsonList.map((json) => HomeModel.fromJson(json)).toList();
    // } else {
    //   throw ServerException(message: 'Failed to fetch items');
    // }

    // Returning mock data for now
    await Future.delayed(const Duration(seconds: 1));
    return [
      HomeModel(
        id: '1',
        title: 'Welcome',
        description: 'Welcome to Clean Architecture Flutter App',
        createdAt: DateTime.now(),
      ),
      HomeModel(
        id: '2',
        title: 'Getting Started',
        description: 'Start building your features',
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<HomeModel> getHomeItem(String id) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return HomeModel(
      id: id,
      title: 'Item $id',
      description: 'Description for item $id',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<HomeModel> createHomeItem(HomeModel model) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return model;
  }

  @override
  Future<HomeModel> updateHomeItem(HomeModel model) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    return model;
  }

  @override
  Future<void> deleteHomeItem(String id) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
