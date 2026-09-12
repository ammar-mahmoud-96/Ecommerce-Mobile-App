import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/network_info.dart';
import '../../data/datasources/home_local_datasource.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_items.dart';
import 'home_notifier.dart';
import 'home_state.dart';

/// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});

/// Provider for InternetConnectionChecker
final internetConnectionCheckerProvider = Provider<InternetConnectionChecker>((
  ref,
) {
  return InternetConnectionChecker.createInstance();
});

/// Provider for NetworkInfo
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(ref.watch(internetConnectionCheckerProvider));
});

/// Provider for HomeRemoteDataSource
final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSourceImpl();
});

/// Provider for HomeLocalDataSource
final homeLocalDataSourceProvider = Provider<HomeLocalDataSource>((ref) {
  return HomeLocalDataSourceImpl(ref.watch(sharedPreferencesProvider));
});

/// Provider for HomeRepository
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    remoteDataSource: ref.watch(homeRemoteDataSourceProvider),
    localDataSource: ref.watch(homeLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

/// Provider for GetHomeItems use case
final getHomeItemsProvider = Provider<GetHomeItems>((ref) {
  return GetHomeItems(ref.watch(homeRepositoryProvider));
});

/// Provider for HomeNotifier (StateNotifierProvider)
final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>((
  ref,
) {
  return HomeNotifier(ref.watch(getHomeItemsProvider));
});
