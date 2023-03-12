import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/home_page.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/splash_page';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(
          20.0,
          MediaQuery.of(context).size.height / 2 - 160,
          20.0,
          20.0,
        ),
        children: [
          Image.asset(
            "assets/images/borgar.png",
            width: 150,
            height: 150,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const NameField(),
          )
        ],
      ),
    );
  }
}

class NameField extends StatefulWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(32.0),
      children: [
        TextField(
          controller: _controller,
          autofocus: false,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16.0,
          ),
          decoration: const InputDecoration(
            hintText: 'Enter your name here',
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: FilledButton(
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, HomePage.routeName,
                  arguments: _controller.text);
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
