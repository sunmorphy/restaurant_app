import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

import '../common/result_state.dart';
import '../common/styles.dart';
import '../widgets/empty_widget.dart';
import '../widgets/restaurant_item.dart';
import '../widgets/warning_widget.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite_page';
  final String username;

  const FavoritePage({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Widget _buildFavorite(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 20.0, top: 70.0, right: 20.0),
          children: [
            RichText(
              text: TextSpan(
                text: 'Hello ',
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: widget.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: '!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              height: 5.0,
              color: secondaryColor,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const ListTile(
              title: Text(
                'Favorite Restaurants',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Here\'s your favorite restaurants\nDon\'t forget to visit them!'),
            ),
            _buildList(context)
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Padding(
            padding: EdgeInsets.only(
              top: 64.0,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.result.length,
            itemBuilder: (context, index) {
              var restaurant = state.result[index];
              return RestaurantItem(
                restaurant: restaurant,
                isFavoritePage: true,
              );
            },
          );
        } else if (state.state == ResultState.noData) {
          return EmptyWidget(
            message: state.message,
          );
        } else if (state.state == ResultState.error) {
          return WarningWidget(
            message: state.message,
          );
        } else {
          return const Center(
            child: Text(
              '',
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildFavorite(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildFavorite(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantFavoriteProvider>(
      create: (_) => RestaurantFavoriteProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
