/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';
  final List<Restaurants> favoriteRestaurants;

  const FavoritePage({Key? key, required this.favoriteRestaurants}) : super(key: key);

  Widget _buildFavorite(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20.0, top: 100.0, right: 20.0),
        children: [
          const ListTile(
            title: Text(
              'Favorite Restaurant',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Don\'t forget to visit them!'),
          ),
          ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: favoriteRestaurants.length,
          itemBuilder: (context, index) {
            if (favoriteRestaurants[index].isFavorite == false) {
              return const Center(
                child: Text('You haven\'t add any favorite here'),
              );
            }
            return _buildItemList(context, favoriteRestaurants[index]);
          },
        )
          // _buildList(context)
        ],
      ),
    ));
  }
/*
  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurants> restaurants = parseRestaurants(snapshot.data);
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            if (restaurants[index].isFavorite == false) {
              return const Center(
                child: Text('You haven\'t add any favorite here'),
              );
            }
            return _buildItemList(context, restaurants[index]);
          },
        );
      },
    );
  }
*/
  Widget _buildItemList(BuildContext context, Restaurants favoriteRestaurants) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      leading: SizedBox(
        width: 110,
        height: 120,
        child: Hero(
          tag: favoriteRestaurants.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              favoriteRestaurants.pictureId,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        favoriteRestaurants.name,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(favoriteRestaurants.city),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: favoriteRestaurants);
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
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
*/