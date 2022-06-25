part of 'episodies_bloc.dart';

enum Status { loading, loaded, error }

class EpisodieState extends Equatable {
  final Status status;
  final List<Episodie> listEpisodie;
  const EpisodieState({
    required this.status,
    required this.listEpisodie,
  });

  EpisodieState copyWith({
    Status? status,
    List<Episodie>? listEpisodie,
  }) =>
      EpisodieState(
        status: status ?? this.status,
        listEpisodie: listEpisodie ?? this.listEpisodie,
      );

  @override
  List<Object> get props => [
        status,
        listEpisodie,
      ];
}
