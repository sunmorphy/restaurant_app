import 'package:flutter/material.dart';

class ShowErrorWidget extends StatelessWidget {
  String message;

  ShowErrorWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 64.0,
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
