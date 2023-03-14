import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/models/restaurant_search.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    _fetchRestaurant();
  }

  late RestaurantSearch _restaurantsSearch;
  late ResultState _state;
  String _message = '';
  String _query = '';

  RestaurantSearch get result => _restaurantsSearch;

  ResultState get state => _state;

  String get message => _message;

  String get query => _query;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchRestaurant = await apiService.fetchByQuery(_query);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsSearch = searchRestaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error : \nYou must connect to a network';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error :\n$e';
    }
  }

  void onSearch(String query) {
    _query = query;
    _fetchRestaurant();
  }
}
