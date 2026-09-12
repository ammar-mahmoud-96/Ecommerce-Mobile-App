import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/home_model.dart';

/// Implementation of HomeRepository
/// Handles data source coordination and error handling
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<HomeEntity>>> getHomeItems() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteItems = await remoteDataSource.getHomeItems();
        await localDataSource.cacheHomeItems(remoteItems);
        return Right(remoteItems);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      }
    } else {
      try {
        final localItems = await localDataSource.getCachedHomeItems();
        return Right(localItems);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, HomeEntity>> getHomeItem(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.getHomeItem(id);
        return Right(item);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, HomeEntity>> createHomeItem(HomeEntity item) async {
    if (await networkInfo.isConnected) {
      try {
        final model = HomeModel.fromEntity(item);
        final createdItem = await remoteDataSource.createHomeItem(model);
        return Right(createdItem);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, HomeEntity>> updateHomeItem(HomeEntity item) async {
    if (await networkInfo.isConnected) {
      try {
        final model = HomeModel.fromEntity(item);
        final updatedItem = await remoteDataSource.updateHomeItem(model);
        return Right(updatedItem);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteHomeItem(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteHomeItem(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
