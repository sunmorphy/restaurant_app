import 'package:flutter/widgets.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantFavoriteProvider({required this.databaseHelper}) {
    getFavoriteRestaurants();
  }

  List<RestaurantElement> _restaurants = [];
  ResultState _state = ResultState.loading;
  String _message = '';

  List<RestaurantElement> get result => _restaurants;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> getFavoriteRestaurants() async {
    _restaurants = await databaseHelper.getFavorites();
    if (_restaurants.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void addFavorite(RestaurantElement restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error :\n$e';
      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error :\n$e';
      notifyListeners();
    }
  }
}
