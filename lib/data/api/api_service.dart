import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Restaurants> fetchList() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<RestaurantDetail> fetchDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + id));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }
}
