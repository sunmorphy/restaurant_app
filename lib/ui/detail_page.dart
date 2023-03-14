import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

import '../common/result_state.dart';
import '../data/db/database_helper.dart';
import '../provider/restaurant_favorite_provider.dart';
import '../widgets/warning_widget.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantElement restaurant;

  const DetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Widget _buildDetail(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (
          context,
          state,
          _,
        ) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hasData) {
            var data = state.result;
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 300,
                    title: Text(
                      data.restaurant.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: secondaryColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          SizedBox.expand(
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/medium/${data.restaurant.pictureId}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: ListView(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 20.0,
                  right: 20.0,
                ),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.pin_drop_outlined,
                              size: 24.0,
                              color: Colors.red.shade500,
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              '${data.restaurant.address}, ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data.restaurant.city,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          data.restaurant.description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'Categories',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Wrap(
                          spacing: 4.0,
                          children: List.generate(
                            data.restaurant.categories.length,
                            (index) => Text(
                              index == data.restaurant.categories.length - 1
                                  ? data.restaurant.categories[index].name
                                  : '${data.restaurant.categories[index].name}, ',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'Foods',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: GridView.count(
                            crossAxisCount: 1,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              data.restaurant.menus.foods.length,
                              (index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: SizedBox(
                                    width: 150.0,
                                    height: 150.0,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Image.asset(
                                            "assets/images/food.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: <Color>[
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.transparent,
                                                ],
                                                tileMode: TileMode.repeated,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              data.restaurant.menus.foods[index]
                                                  .name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'Drinks',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 150.0,
                          width: double.infinity,
                          child: GridView.count(
                            crossAxisCount: 1,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              data.restaurant.menus.drinks.length,
                              (index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: SizedBox(
                                    width: 150.0,
                                    height: 150.0,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Image.asset(
                                            "assets/images/drink.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: <Color>[
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              data.restaurant.menus
                                                  .drinks[index].name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              'Reviews',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: secondaryColor,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 16.0,
                                    color: secondaryColor,
                                  ),
                                  Text(
                                    data.restaurant.rating.toString(),
                                    style: const TextStyle(
                                        color: secondaryColor, fontSize: 16.0),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.restaurant.customerReviews.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListView(
                                padding: const EdgeInsets.all(8.0),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        data.restaurant.customerReviews[index]
                                            .name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        data.restaurant.customerReviews[index]
                                            .date,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    data.restaurant.customerReviews[index]
                                        .review,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            );
          } else if (state.state == ResultState.noData) {
            return WarningWidget(
              message: state.message,
            );
          } else if (state.state == ResultState.error) {
            return WarningWidget(
              message: state.message,
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
      floatingActionButton: Consumer<RestaurantFavoriteProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isFavorite(widget.restaurant.id),
            builder: (context, snapshot) {
              var isFavorite = snapshot.data ?? false;
              return isFavorite
                  ? FloatingActionButton.large(
                      backgroundColor: Colors.white,
                      hoverColor: Colors.red.shade400.withOpacity(0.6),
                      focusColor: Colors.red.shade400.withOpacity(0.6),
                      onPressed: () =>
                          provider.removeFavorite(widget.restaurant.id),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 32.0,
                        color: Colors.red.shade400,
                      ),
                    )
                  : FloatingActionButton.large(
                      backgroundColor: Colors.white,
                      hoverColor: Colors.red.shade400.withOpacity(0.6),
                      focusColor: Colors.red.shade400.withOpacity(0.6),
                      onPressed: () => provider.addFavorite(widget.restaurant),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 32.0,
                        color: Colors.red.shade400,
                      ),
                    );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(
            apiService: ApiService(),
            id: widget.restaurant.id,
          ),
        ),
        ChangeNotifierProvider<RestaurantFavoriteProvider>(
          create: (_) => RestaurantFavoriteProvider(
            databaseHelper: DatabaseHelper(),
          ),
        )
      ],
      child: _buildDetail(context),
    );
  }
}
