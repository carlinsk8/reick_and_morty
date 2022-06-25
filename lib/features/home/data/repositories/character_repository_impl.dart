import 'package:rick_and_morty/features/home/data/datasources/local/character_local_data_source.dart';
import 'package:rick_and_morty/features/home/domain/entities/character.dart';

import 'package:rick_and_morty/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/character_repository.dart';
import '../datasources/remote/character_remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource characterRemoteDataSource;
  final CharacterLocalDataSource characterLocalDataSource;

  CharacterRepositoryImpl({
    required this.characterRemoteDataSource,
    required this.characterLocalDataSource,
  });

  @override
  Future<Either<Failure, Character>> getCharacter({required String id}) async {
    try {
      final res = await characterRemoteDataSource.getCharacter(id: id);

      return Right(res);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getCharacters(
      {required String page,
      String? name,
      String? gender,
      required bool favorites}) async {
    try {
      final res = await characterRemoteDataSource.getCharacters(
          page: page, name: name, gender: gender, favorites: favorites);

      return Right(res);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setFavoriteCharacter(
      {required String id}) async {
    try {
      final res = await characterLocalDataSource.setFavorite(id);

      return Right(res);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Either<Failure, List<String>> getFavorites() {
    try {
      final res = characterLocalDataSource.getFavorites();

      return Right(res);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
