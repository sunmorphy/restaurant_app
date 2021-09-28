import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  bool isFavorite;

  FavoriteButton({Key? key, required this.isFavorite}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
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
        widget.isFavorite ? Icons.favorite_border : Icons.favorite,
        size: 24.0,
        color: Colors.red.shade400,
      ),
      onPressed: () {
        setState(() {
          widget.isFavorite = !widget.isFavorite;
        });
      },
    );
  }
}
