import 'package:equatable/equatable.dart';
import '../../domain/entities/home_entity.dart';

/// Base class for all home states
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Loading state
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Loaded state with data
class HomeLoaded extends HomeState {
  final List<HomeEntity> items;

  const HomeLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

/// Error state
class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
