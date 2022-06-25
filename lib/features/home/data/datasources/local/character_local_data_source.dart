import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class CharacterLocalDataSource {
  Future<bool> setFavorite(String id);
  List<String> getFavorites();
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CharacterLocalDataSourceImpl({required this.sharedPreferences});
  static const favorite = 'favorite';
  @override
  List<String> getFavorites() {
    final jsonStr = sharedPreferences.getString(favorite);
    if (jsonStr == null) {
      return [];
    }
    return List<String>.from(json.decode(jsonStr).map((x) => x));
  }

  @override
  Future<bool> setFavorite(String id) {
    final list = getFavorites();
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }

    return sharedPreferences.setString(favorite, json.encode(list));
  }
}
