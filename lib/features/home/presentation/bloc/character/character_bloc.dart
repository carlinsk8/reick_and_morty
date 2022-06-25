import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/features/home/domain/usecase/get_character_usecase.dart';

import '../../../domain/entities/character.dart';
import '../../../domain/usecase/set_favorite_character_usecase.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacterUseCase getCharacterUseCase;
  final SetFavoriteCharacterUseCase setFavoriteCharacterUseCase;

  CharacterBloc({
    required this.getCharacterUseCase,
    required this.setFavoriteCharacterUseCase,
  }) : super(const CharacterState(
          status: Status.loading,
          listCharacter: [],
          page: '1',
          gender: '',
          name: '',
          favorites: false,
        )) {
    on<GetCharacterEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final result =
          await getCharacterUseCase(GetCharacterParams(page: state.page));
      emit(result.fold(
        (failure) => state.copyWith(
          status: Status.error,
        ),
        (data) {
          return state.copyWith(status: Status.loaded, listCharacter: data);
        },
      ));
    });
    on<GetCharacterFilterEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      final result = await getCharacterUseCase(GetCharacterParams(
          page: '1',
          name: event.name,
          gender: event.gender,
          favorites: event.favorites));
      emit(state.copyWith(favorites: event.favorites, page: '1'));
      emit(result.fold(
        (failure) => state.copyWith(
          status: Status.error,
        ),
        (data) {
          return state.copyWith(status: Status.loaded, listCharacter: data);
        },
      ));
    });
    on<SetFavoriteEvent>((event, emit) async {
      // emit(state.copyWith(status: Status.loading));
      final result = await setFavoriteCharacterUseCase(event.id.toString());
      emit(result.fold(
        (failure) => state.copyWith(
          status: Status.error,
        ),
        (ok) {
          List<Character> data = [];
          for (var e in state.listCharacter) {
            if (e.id == event.id) {
              e.favorite = true;
            }
            data.add(e);
          }

          return state.copyWith(status: Status.loaded, listCharacter: data);
        },
      ));
    });
    on<SetPaginationEvent>((event, emit) async {
      int page = int.parse(state.page);
      if (!state.favorites) {
        final result = await getCharacterUseCase(GetCharacterParams(
          page: (page + 1).toString(),
          gender: state.gender,
          name: state.name,
          favorites: state.favorites,
        ));
        emit(state.copyWith(
          page: (page + 1).toString(),
          gender: state.gender,
          name: state.name,
          favorites: state.favorites,
        ));
        emit(result.fold(
          (failure) => state.copyWith(
            status: Status.error,
          ),
          (data) {
            List<Character> list = state.listCharacter;
            // for (var e in list) {
            //   if (!(data.map((e) => e.id).contains(e.id))) {
            //     list.add(e);
            //   }
            // }
            list.addAll(data);
            return state.copyWith(status: Status.loaded, listCharacter: list);
          },
        ));
      }
    });
  }
}
