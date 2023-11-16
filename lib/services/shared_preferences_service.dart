import 'dart:convert';
import 'package:rick_and_morty/models/rick_and_morty_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  SharedPreferences? _preferences;

  static const String dataKey = "RickAndMortyData";
  static const String pageKey = "MaxPage";
  static const String tutorialKey = "Tutorial";

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesService();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setValue(String key, dynamic value) async {
    switch (value) {
      case String():
        await _preferences!.setString(key, value);
        break;
      case int():
        await _preferences!.setInt(key, value);
        break;
      case double():
        await _preferences!.setDouble(key, value);
        break;
      case bool():
        await _preferences!.setBool(key, value);
        break;
    }
  }

  Future<dynamic> getValue(String key) async {
    switch (key) {
      case pageKey:
        return _preferences!.getInt(key);
      case tutorialKey:
        return _preferences!.getBool(key);
    }
  }

  Future<void> saveData(String key, List<RickAndMortyDataModel> data) async {
    if (_preferences != null) {
      List<Map<String, dynamic>> jsonDataList = data.map((model) => model.toJson()).toList();
      String jsonData = jsonEncode(jsonDataList);
      await _preferences!.setString(key, jsonData);
    }
  }

  List<RickAndMortyDataModel> getData(String key) {
    if (_preferences != null) {
      String? jsonData = _preferences!.getString(key);
      if (jsonData != null) {
        List<dynamic> jsonList = jsonDecode(jsonData);
        return jsonList.map((json) => RickAndMortyDataModel.fromJson(json)).toList();
      }
    }
    return [];
  }

  Future<void> clearAllData() async {
    if (_preferences != null) {
      await _preferences!.clear();
    }
  }
}
