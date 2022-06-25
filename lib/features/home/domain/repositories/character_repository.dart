import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters({
    required String page,
    String? name,
    String? gender,
    required bool favorites,
  });
  Future<Either<Failure, Character>> getCharacter({required String id});
  Future<Either<Failure, bool>> setFavoriteCharacter({required String id});
  Either<Failure, List<String>> getFavorites();
  Future<Either<Failure, List<Episodie>>> getEpisodies(
      {required List<String> episodies});
}
