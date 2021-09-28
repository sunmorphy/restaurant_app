import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/common/styles.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildHome(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20.0, top: 70.0, right: 20.0),
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Hello ',
                  style: Theme.of(context).textTheme.bodyText1,
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
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red.shade400,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, FavoritePage.routeName,
                      arguments: _buildList(context));
                },
              )
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(
            height: 5.0,
            color: secondaryColor,
          ),
          const SizedBox(height: 10.0),
          const ListTile(
            title: Text(
              'Restaurant',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Here\'s a restaurant recommendation for you!'),
          ),
          _buildList(context)
        ],
      ),
    ));
  }

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
            return _buildItemList(context, restaurants[index]);
          },
        );
      },
    );
  }

  Widget _buildItemList(BuildContext context, Restaurants restaurants) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      leading: SizedBox(
        width: 110,
        height: 120,
        child: Hero(
          tag: restaurants.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox.expand(
              child: Image.network(
                restaurants.pictureId,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        restaurants.name,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(restaurants.city),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurants);
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildHome(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildHome(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
