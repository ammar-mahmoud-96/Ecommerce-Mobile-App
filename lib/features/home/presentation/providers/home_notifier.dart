import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_home_items.dart';
import 'home_state.dart';

/// StateNotifier for managing home feature state
class HomeNotifier extends StateNotifier<HomeState> {
  final GetHomeItems _getHomeItems;

  HomeNotifier(this._getHomeItems) : super(const HomeInitial());

  /// Load home items
  Future<void> loadHomeItems() async {
    state = const HomeLoading();

    final result = await _getHomeItems(const NoParams());

    result.fold(
      (failure) => state = HomeError(failure.message),
      (items) => state = HomeLoaded(items),
    );
  }

  /// Refresh home items (doesn't show loading state)
  Future<void> refreshHomeItems() async {
    final result = await _getHomeItems(const NoParams());

    result.fold(
      (failure) => state = HomeError(failure.message),
      (items) => state = HomeLoaded(items),
    );
  }
}
