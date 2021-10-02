import 'package:floor/floor.dart';
import 'package:restaurant_app/models/restaurant_favorite.dart';
import 'package:restaurant_app/restaurant_favorite_dao.dart';

@Database(version: 1, entities: [RestaurantFavorite])
abstract class AppDatabase extends FloorDatabase {
  FavoriteDao get favoriteDao;
}
