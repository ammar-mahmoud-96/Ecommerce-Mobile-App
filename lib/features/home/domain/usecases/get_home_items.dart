import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

/// Use case for getting all home items
class GetHomeItems implements UseCase<List<HomeEntity>, NoParams> {
  final HomeRepository repository;

  GetHomeItems(this.repository);

  @override
  Future<Either<Failure, List<HomeEntity>>> call(NoParams params) async {
    return await repository.getHomeItems();
  }
}
