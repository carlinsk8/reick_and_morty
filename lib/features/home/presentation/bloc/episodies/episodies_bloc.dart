import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/character.dart';
import '../../../domain/usecase/get_episode_use_case.dart';

part 'episodies_event.dart';
part 'episodies_state.dart';

class EpisodiesBloc extends Bloc<EpisodiesEvent, EpisodieState> {
  final GetEpisodiesUseCase getEpisodiesUseCase;
  EpisodiesBloc({
    required this.getEpisodiesUseCase,
  }) : super(const EpisodieState(status: Status.loading, listEpisodie: [])) {
    on<GetEpisodiesEvent>((event, emit) async {
      final result = await getEpisodiesUseCase(event.list);
      emit(result.fold(
        (failure) => state.copyWith(
          status: Status.error,
        ),
        (data) {
          return state.copyWith(status: Status.loaded, listEpisodie: data);
        },
      ));
    });
  }
}
