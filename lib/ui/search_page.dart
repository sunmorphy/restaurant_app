import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/restaurant_search.dart';
import 'package:restaurant_app/restaurant_provider.dart';
import 'package:restaurant_app/restaurant_search_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<Restaurants> _restaurants;
  late Future<RestaurantSearch> _restaurantSearch;
  // var rows = [];
  final TextEditingController _controller = TextEditingController();
  String query = '';

  @override
  void initState() {
    super.initState();
    _restaurants = ApiService().fetchList();
    _restaurantSearch = ApiService().fetchByQuery(query);
  }

  // @override
  Widget _build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20.0, top: 70.0, right: 20.0),
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search restaurant...',
              border: InputBorder.none,
            ),
            onChanged: (v) {
              setState(() {
                query = v;
              });
            },
          ),
          const SizedBox(height: 10.0),
          const Divider(
            height: 5.0,
            color: secondaryColor,
          ),
          const SizedBox(height: 10.0),
          const ListTile(
            title: Text(
              'Search Restaurant',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Find your wanted restaurant!'),
          ),
          _buildList(context)
        ],
      ),
    ));
    /*Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 20.0, top: 70.0, right: 20.0),
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Search restaurant...',
                  border: InputBorder.none,
                ),
                onChanged: (v) {
                  setState(() {
                    query = v;
                  });
                },
              ),
              const SizedBox(height: 10.0),
              const Divider(
                height: 5.0,
                color: secondaryColor,
              ),
              const SizedBox(height: 10.0),
              const ListTile(
                title: Text(
                  'Search Restaurant',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Find your wanted restaurant!'),
              ),
              _buildList(context)
            ],
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    ));*/
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _build(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _build(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
        create: (_) =>
            RestaurantSearchProvider(apiService: ApiService(), query: query),
        child: PlatformWidget(
            androidBuilder: _buildAndroid, iosBuilder: _buildIos));
  }

  Widget _buildList(BuildContext context) {
    return query.isEmpty
        ? FutureBuilder(
            future: _restaurants,
            builder: (context, AsyncSnapshot<Restaurants> snapshot) {
              var state = snapshot.connectionState;

              if (state != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = snapshot.data?.restaurants[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        leading: SizedBox(
                          width: 120,
                          height: 100,
                          child: Hero(
                            tag: restaurant!.pictureId,
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
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(restaurant.city),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RestaurantDetailPage.routeName,
                              arguments: restaurant.id);
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Text('');
                }
              }
              /*
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
        */
            },
          )
        /*Consumer<RestaurantProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
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
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(restaurant.city),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RestaurantDetailPage.routeName,
                          arguments: restaurant.id);
                    },
                  );
                },
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          })*/
        : FutureBuilder(
            future: _restaurantSearch,
            builder: (context, AsyncSnapshot<RestaurantSearch> snapshot) {
              var state = snapshot.connectionState;

              if (state != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return blabla(data);

                  /*
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data?.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = data?.restaurants[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        leading: SizedBox(
                          width: 120,
                          height: 100,
                          child: Hero(
                            tag: restaurant!.pictureId,
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
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(restaurant.city),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RestaurantDetailPage.routeName,
                              arguments: restaurant.id);
                        },
                      );
                    },
                  );*/
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Text('');
                }
              }
            },
          );
    /*Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
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
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(restaurant.city),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RestaurantDetailPage.routeName,
                          arguments: restaurant.id);
                    },
                  );
                },
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          });*/
  }

  Widget blabla(RestaurantSearch? data) {
    if (data != null) {
      for (var element in data.restaurants) {
        if (element.name.contains(query.toLowerCase()) ||
            element.name.characters.contains(query.toLowerCase())) {
          var elementLength = data.restaurants
              .where((element) =>
                  element.name.contains(query) ||
                  element.name.characters.contains(query))
              .toList();
          // elementLength.addAll(data.restaurants);
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: elementLength.length,
            itemBuilder: (context, index) {
              // var restaurant = data.restaurants[index];
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                leading: SizedBox(
                  width: 120,
                  height: 100,
                  child: Hero(
                    tag: element.pictureId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox.expand(
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${element.pictureId}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  element.name,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(element.city),
                onTap: () {
                  Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                      arguments: element.id);
                },
              );
            },
          );
        }
      }
    }

    return const Center(
        child: Text('Sorry, cannot find restaurant that you wanted'));
    // return const Center(child: Text('test'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
