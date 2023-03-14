import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/restaurant_detail.dart';
import 'package:restaurant_app/models/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _list = '/list';
  static const String _detail = '/detail/';
  static const String _search = '/search?q=';

  Future<Restaurants> fetchList() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));

    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<RestaurantDetail> fetchDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }

  Future<RestaurantSearch> fetchByQuery(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list');
    }
  }
}
