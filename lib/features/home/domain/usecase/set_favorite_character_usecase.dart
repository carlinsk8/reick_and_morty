import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/character_repository.dart';

class SetFavoriteCharacterUseCase implements UseCase<bool, String> {
  final CharacterRepository repository;

  SetFavoriteCharacterUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(params) async {
    final result = await repository.setFavoriteCharacter(
      id: params,
    );

    return result.fold(
      (error) => Left(error),
      (product) => Right(product),
    );
  }
}
