import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class FavoriteButton extends StatelessWidget {
  // final List<Restaurants> favoriteRestaurant;
  // final Restaurants favoriteRestaurants;
  bool isFavorite;
  late final List<RestaurantElement> _search = [];

  // final void onClick;

  FavoriteButton({Key? key, required this.isFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    return ElevatedButton(
      child: Center(
        child: Icon(
          isFavorite ? Icons.favorite_border : Icons.favorite,
          size: 18.0,
          color: Colors.red.shade400,
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.red.shade100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
    */
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite_border : Icons.favorite,
        size: 24.0,
        color: Colors.red.shade400,
      ),
      onPressed: () {
        isFavorite = !isFavorite;
      },
    );
  }
}
/*
class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    /*
    return ElevatedButton(
      child: Center(
        child: Icon(
          isFavorite ? Icons.favorite_border : Icons.favorite,
          size: 18.0,
          color: Colors.red.shade400,
        ),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.red.shade100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
    */
    return IconButton(
      icon: Icon(
        widget.favoriteRestaurants.isFavorite
            ? Icons.favorite_border
            : Icons.favorite,
        size: 24.0,
        color: Colors.red.shade400,
      ),
      onPressed: widget.onClick,
    );
  }
}
*/
