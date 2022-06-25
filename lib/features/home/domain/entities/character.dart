import 'package:equatable/equatable.dart';

class Character extends Equatable {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
    this.favorite = false,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;
  bool favorite;

  @override
  List<Object> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
        created,
        favorite,
      ];
}

class Location extends Equatable {
  const Location({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  @override
  List<Object?> get props => [name, url];
}

class Episodie extends Equatable {
  const Episodie({
    required this.airDate,
    required this.episode,
    required this.name,
  });

  final String name;
  final String airDate;
  final String episode;

  @override
  List<Object?> get props => [name, airDate, episode];
}
