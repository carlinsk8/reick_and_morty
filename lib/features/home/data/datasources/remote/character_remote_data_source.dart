import 'dart:convert';

import 'package:rick_and_morty/core/api/public_http_client.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/character_model.dart';
import '../local/character_local_data_source.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(
      {required String page,
      String? name,
      String? gender,
      required bool favorites});
  Future<CharacterModel> getCharacter({required String id});
}

class CharacterRemoteDataSourceImpl extends CharacterRemoteDataSource {
  final PublicHttpClient publicHttpClient;
  final CharacterLocalDataSource characterLocalDataSource;

  CharacterRemoteDataSourceImpl({
    required this.publicHttpClient,
    required this.characterLocalDataSource,
  });

  @override
  Future<CharacterModel> getCharacter({required String id}) async {
    final response = await publicHttpClient.get(
      '/api/character/$id',
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return CharacterModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CharacterModel>> getCharacters(
      {required String page,
      String? name,
      String? gender,
      required bool favorites}) async {
    final listFavorite = characterLocalDataSource.getFavorites();
    final queryParams = {"page": page};
    if (name != null && name != '') queryParams['name'] = name;
    if (gender != null && gender != '') queryParams['gender'] = gender;
    var url = '/api/character/';
    if (favorites) {
      url =
          '/api/character/${json.encode(listFavorite).replaceAll('[', '').replaceAll(']', '').replaceAll('"', '')}';
    }
    final response = await publicHttpClient.get(url, queryParams: queryParams);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = {};
      try {
        data = json.decode(response.body);
      } catch (e) {
        data['results'] = json.decode(response.body);
      }
      Map<String, dynamic> aux = {};
      aux['results'] = [data];
      final dataD = data['results'] ?? aux['results'];
      List<Map<String, dynamic>> listResult =
          List<Map<String, dynamic>>.from(dataD.map((e) => e));
      for (var i = 0; i < listResult.length; i++) {
        if (listFavorite.contains(listResult[i]['id'].toString())) {
          listResult[i]['favorite'] = true;
        }
      }

      final listCharacter = List<CharacterModel>.from(
          listResult.map((e) => CharacterModel.fromJson(e)));
      return listCharacter;
    } else {
      throw ServerException();
    }
  }

  Future<Map<String, dynamic>> getEpisode({required String url}) async {
    var split = url.split('https://rickandmortyapi.com/');
    final response = await publicHttpClient.get(
      split[1],
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data;
    }
    return {};
  }
}
