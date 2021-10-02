import 'package:flutter/widgets.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final ApiService apiService;

  // RestaurantProvider({required this.apiService}): assert(_fetchAllRestaurant);
  RestaurantFavoriteProvider({required this.apiService}) {
    _fetchFavoriteRestaurant();
  }

  late Restaurants _restaurants;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  Restaurants get result => _restaurants;

  ResultState get state => _state;

  Future<dynamic> _fetchFavoriteRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.fetchFavorite();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurants = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
