import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lottie/box-floating.json",
            repeat: true,
          ),
          const SizedBox(
            height: 18.0,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
