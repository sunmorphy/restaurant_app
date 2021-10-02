import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/models/restaurant_search.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  // RestaurantProvider({required this.apiService}): assert(_fetchAllRestaurant);
  RestaurantSearchProvider({required this.apiService}) {
    _fetchRestaurant();
  }

  late RestaurantSearch _restaurantsSearch;
  late ResultState _state;
  String _message = '';
  String _query = '';

  String get message => _message;

  String get query => _query;

  RestaurantSearch get result => _restaurantsSearch;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final searchRestaurant = await apiService.fetchByQuery(_query);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsSearch = searchRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  void onSearch(String query) {
    _query = query;
    _fetchRestaurant();
  }
}
