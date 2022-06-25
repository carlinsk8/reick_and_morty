part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class GetCharacterEvent extends CharacterEvent {}

class GetCharacterFilterEvent extends CharacterEvent {
  final String gender;
  final String name;
  final bool favorites;
  const GetCharacterFilterEvent({
    this.gender = '',
    this.name = '',
    this.favorites = false,
  });
}

class SetFavoriteEvent extends CharacterEvent {
  final int id;

  const SetFavoriteEvent(this.id);
}

class SetPaginationEvent extends CharacterEvent {}
