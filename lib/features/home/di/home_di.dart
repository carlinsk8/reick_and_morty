import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/home/domain/usecase/set_favorite_character_usecase.dart';

import '../data/datasources/local/character_local_data_source.dart';
import '../data/datasources/remote/character_remote_data_source.dart';
import '../data/repositories/character_repository_impl.dart';
import '../domain/repositories/character_repository.dart';
import '../domain/usecase/get_character_usecase.dart';
import '../presentation/bloc/character/character_bloc.dart';

initHomeModule(GetIt sl) {
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(
        publicHttpClient: sl(), characterLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CharacterLocalDataSource>(
    () => CharacterLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
        characterRemoteDataSource: sl(), characterLocalDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetCharacterUseCase(sl()));
  sl.registerLazySingleton(() => SetFavoriteCharacterUseCase(sl()));
  sl.registerFactory(
    () => CharacterBloc(
        getCharacterUseCase: sl(), setFavoriteCharacterUseCase: sl()),
  );
}
