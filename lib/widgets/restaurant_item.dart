import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/restaurant.dart';
import '../provider/restaurant_favorite_provider.dart';
import '../ui/detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantElement restaurant;
  final bool isFavoritePage;

  const RestaurantItem({
    super.key,
    required this.restaurant,
    required this.isFavoritePage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      leading: SizedBox(
        width: 120,
        height: 100,
        child: Hero(
          tag: restaurant.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox.expand(
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(restaurant.city),
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailPage.routeName,
          arguments: restaurant,
        ).then((value) {
          if (isFavoritePage) {
            context.read<RestaurantFavoriteProvider>().getFavoriteRestaurants();
          }
        });
      },
    );
  }
}
