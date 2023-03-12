import 'dart:io';

import 'package:flutter/material.dart';

import '../common/result_state.dart';
import '../data/api/api_service.dart';
import '../models/restaurant_detail.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;

  RestaurantDetailProvider({
    required this.apiService,
    required this.id,
  }) {
    _fetchAllRestaurant();
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.fetchDetail(id);
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantDetail = restaurant;
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error : \nYou must connect to a network';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
