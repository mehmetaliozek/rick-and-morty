import 'dart:io';

import 'package:dio/dio.dart';

class RickAndMortyDataService {
  RickAndMortyDataService() : _dio = Dio();

  final Dio _dio;

  String get _baseUrl => "https://rickandmortyapi.com/api/character";

  Future<dynamic> fetchPageCount() async {
    try {
      var response = await _dio.get(_baseUrl);

      if (response.statusCode == HttpStatus.ok) {
        return response.data["info"]["pages"];
      } else {
        return response.statusMessage;
      }
    } catch (e) {
      if (e is DioException) {
        return "";
      }
    }
  }

  Future<dynamic> fetchCharacterData(int pageNumber) async {
    try {
      var response = await _dio.get("$_baseUrl?page=$pageNumber");

      if (response.statusCode == HttpStatus.ok) {
        return response.data["results"];
      } else {
        return response.statusMessage;
      }
    } catch (e) {
      if (e is DioException) {
        return "";
      }
    }
  }
}
