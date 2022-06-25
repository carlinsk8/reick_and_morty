import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetCharacterUseCase
    implements UseCase<List<Character>, GetCharacterParams> {
  final CharacterRepository repository;

  GetCharacterUseCase(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(
      GetCharacterParams params) async {
    final result = await repository.getCharacters(
      page: params.page,
      gender: params.gender,
      name: params.name,
      favorites: params.favorites,
    );

    return result.fold(
      (error) => Left(error),
      (product) => Right(product),
    );
  }
}

class GetCharacterParams extends Equatable {
  final String page;
  final bool favorites;
  final String? gender;
  final String? name;

  const GetCharacterParams({
    required this.page,
    this.favorites = false,
    this.gender,
    this.name,
  });

  @override
  List<Object?> get props => [page, gender, name, favorites];
}
