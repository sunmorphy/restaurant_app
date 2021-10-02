import 'package:floor/floor.dart';
import 'package:restaurant_app/models/restaurant_favorite.dart';

@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM RestaurantFavorite')
  Future<List<RestaurantFavorite>> findAllFavorite();

  @Query('SELECT * FROM RestaurantFavorite WHERE id = :id')
  Stream<RestaurantFavorite?> findFavoriteById(int id);

  @insert
  Future<void> insertFavorite(RestaurantFavorite fav);

  @delete
  Future<void> deleteFavorite(RestaurantFavorite fav);
}
