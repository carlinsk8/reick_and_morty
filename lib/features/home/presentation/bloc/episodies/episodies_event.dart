part of 'episodies_bloc.dart';

abstract class EpisodiesEvent extends Equatable {
  const EpisodiesEvent();

  @override
  List<Object> get props => [];
}

class GetEpisodiesEvent extends EpisodiesEvent {
  final List<String> list;

  const GetEpisodiesEvent(this.list);
}
