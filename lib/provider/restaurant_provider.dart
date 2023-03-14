import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late Restaurants _restaurants;
  late ResultState _state;
  String _message = '';

  Restaurants get result => _restaurants;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.fetchList();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurants = restaurants;
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
}
