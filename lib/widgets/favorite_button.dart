import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final void onClick;

  const FavoriteButton({
    Key? key,
    required this.isFavorite,
    required this.onClick,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 24.0,
        color: Colors.red.shade400,
      ),
      onPressed: () => {
        widget.onClick,
      },
    );
  }
}
