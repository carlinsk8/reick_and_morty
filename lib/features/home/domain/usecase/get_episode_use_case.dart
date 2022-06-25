import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/features/home/domain/entities/character.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/character_repository.dart';

class GetEpisodiesUseCase implements UseCase<List<Episodie>, List<String>> {
  final CharacterRepository repository;

  GetEpisodiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Episodie>>> call(List<String> params) async {
    final result = await repository.getEpisodies(
      episodies: params,
    );

    return result.fold(
      (error) => Left(error),
      (episodies) => Right(episodies),
    );
  }
}
