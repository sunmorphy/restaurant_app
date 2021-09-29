/*import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class FavoriteButton extends StatelessWidget {
  final List<Restaurants> favoriteRestaurant;
  final Restaurants favoriteRestaurants;
  final bool isFavorite;
  // final void onClick;

  const FavoriteButton(
      {Key? key, required this.favoriteRestaurants, required this.isFavorite, required this.onClick})
      : super(key: key);

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
        favoriteRestaurants.isFavorite
            ? Icons.favorite_border
            : Icons.favorite,
        size: 24.0,
        color: Colors.red.shade400,
      ),
      onPressed: onClick,
    );
  }

  void onClick() {
    setState
  }
}

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