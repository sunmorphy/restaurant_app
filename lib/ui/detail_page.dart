import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/common/styles.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurants restaurants;

  const RestaurantDetailPage({Key? key, required this.restaurants})
      : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Widget _buildDetail(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              title: Text(widget.restaurants.name,
                  style: const TextStyle(color: Colors.white)),
              centerTitle: true,
              backgroundColor: secondaryColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  SizedBox.expand(
                    child: Image.network(
                      widget.restaurants.pictureId,
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
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ];
        },
        body: ListView(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: 90,
                height: 30,
                child: Card(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                      child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                      ),
                      Text(widget.restaurants.rating.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16.0)),
                    ],
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      widget.restaurants.description,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Foods',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
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
                            widget.restaurants.menus.foods.length, (index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Stack(fit: StackFit.expand, children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      "assets/images/food.jpg",
                                      fit: BoxFit.cover,
                                    )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: <Color>[
                                            Colors.black.withOpacity(0.8),
                                            Colors.transparent
                                          ],
                                          tileMode: TileMode.repeated),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      widget
                                          .restaurants.menus.foods[index].name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Drinks',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
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
                            widget.restaurants.menus.drinks.length, (index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Stack(fit: StackFit.expand, children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      "assets/images/drink.jpg",
                                      fit: BoxFit.cover,
                                    )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: <Color>[
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent
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
                                        widget.restaurants.menus.drinks[index]
                                            .name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0)),
                                  ),
                                )
                              ]),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20.0)
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildDetail(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildDetail(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
