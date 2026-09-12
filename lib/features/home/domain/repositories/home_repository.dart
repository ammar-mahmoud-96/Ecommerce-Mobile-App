import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/home_entity.dart';

/// Abstract repository interface for home feature
/// This defines the contract that the data layer must implement
abstract class HomeRepository {
  /// Get all home items
  Future<Either<Failure, List<HomeEntity>>> getHomeItems();

  /// Get a single home item by ID
  Future<Either<Failure, HomeEntity>> getHomeItem(String id);

  /// Create a new home item
  Future<Either<Failure, HomeEntity>> createHomeItem(HomeEntity item);

  /// Update an existing home item
  Future<Either<Failure, HomeEntity>> updateHomeItem(HomeEntity item);

  /// Delete a home item
  Future<Either<Failure, void>> deleteHomeItem(String id);
}
