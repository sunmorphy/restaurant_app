import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';

import '../widgets/platform_widget.dart';
import '../widgets/show_error_widget.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  Widget _buildSearch(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 70.0,
          right: 20.0,
        ),
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search restaurant...',
              border: InputBorder.none,
            ),
            onChanged: (v) {
              Provider.of<RestaurantSearchProvider>(context, listen: false)
                  .onSearch(v);
            },
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
              'Search Restaurant',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Find your wanted restaurant!'),
          ),
          _buildList(context)
        ],
      ),
    ));
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                leading: SizedBox(
                  width: 120,
                  height: 100,
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox.expand(
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  restaurant.city,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RestaurantDetailPage.routeName,
                    arguments: restaurant.id,
                  );
                },
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return ShowErrorWidget(
            message: state.message,
          );
        } else if (state.state == ResultState.Error) {
          return ShowErrorWidget(
            message: state.message,
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildSearch(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildSearch(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(
        apiService: ApiService(),
      ),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
