part of 'character_bloc.dart';

enum Status { loading, loaded, error }

class CharacterState extends Equatable {
  final Status status;
  final String page;
  final String gender;
  final String name;
  final bool favorites;
  final List<Character> listCharacter;
  const CharacterState({
    required this.status,
    required this.listCharacter,
    required this.page,
    required this.gender,
    required this.name,
    required this.favorites,
  });

  CharacterState copyWith({
    Status? status,
    List<Character>? listCharacter,
    String? page,
    String? gender,
    String? name,
    bool? favorites,
  }) =>
      CharacterState(
        status: status ?? this.status,
        listCharacter: listCharacter ?? this.listCharacter,
        page: page ?? this.page,
        gender: gender ?? this.gender,
        name: name ?? this.name,
        favorites: favorites ?? this.favorites,
      );

  @override
  List<Object> get props => [
        status,
        listCharacter,
        page,
        gender,
        name,
        favorites,
      ];
}
