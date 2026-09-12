import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/home_model.dart';

/// Cache key for home items
const cachedHomeItems = 'CACHED_HOME_ITEMS';

/// Abstract class for local data source
abstract class HomeLocalDataSource {
  /// Get cached home items
  Future<List<HomeModel>> getCachedHomeItems();

  /// Cache home items locally
  Future<void> cacheHomeItems(List<HomeModel> items);

  /// Clear cached home items
  Future<void> clearCache();
}

/// Implementation of HomeLocalDataSource using SharedPreferences
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<HomeModel>> getCachedHomeItems() async {
    final jsonString = sharedPreferences.getString(cachedHomeItems);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => HomeModel.fromJson(json)).toList();
    } else {
      throw const CacheException(message: 'No cached data found');
    }
  }

  @override
  Future<void> cacheHomeItems(List<HomeModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await sharedPreferences.setString(cachedHomeItems, json.encode(jsonList));
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(cachedHomeItems);
  }
}
