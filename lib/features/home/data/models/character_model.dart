import 'package:rick_and_morty/features/home/domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required Location origin,
    required Location location,
    required String image,
    required List<String> episode,
    required String url,
    required DateTime created,
    bool favorite = false,
  }) : super(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            url: url,
            created: created,
            favorite: favorite);
  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: LocationModel.fromJson(json["origin"]),
        location: LocationModel.fromJson(json["location"]),
        image: json['image'],
        episode: List<String>.from(json["episode"].map((x) => x)),
        // episode: List<EpisodieModel>.from(
        //     json["episode"].map((x) => EpisodieModel.fromJson(x))),
        url: json['url'],
        created: DateTime.parse(json["created"]),
        favorite: json['favorite'] ?? false,
      );
}

class LocationModel extends Location {
  const LocationModel({
    required String name,
    required String url,
  }) : super(
          name: name,
          url: url,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class EpisodieModel extends Episodie {
  const EpisodieModel({
    required String name,
    required String airDate,
    required String episode,
  }) : super(
          name: name,
          airDate: airDate,
          episode: episode,
        );

  factory EpisodieModel.fromJson(Map<String, dynamic> json) => EpisodieModel(
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "airDate": airDate,
        "episodie": episode,
      };
}
