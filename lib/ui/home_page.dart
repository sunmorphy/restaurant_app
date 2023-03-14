import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/preference/preference_helper.dart';
import '../provider/preference_provider.dart';
import '../utils/notification_helper.dart';
import '../widgets/empty_widget.dart';
import '../widgets/warning_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  Widget _buildHome(BuildContext context) {
    return Consumer<PreferenceProvider>(
      builder: (context, provider, _) {
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
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Hello ',
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: provider.username,
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
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SearchPage.routeName,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red.shade400),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          FavoritePage.routeName,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_rounded),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SettingsPage.routeName,
                        );
                      },
                    )
                  ],
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
                    'Restaurants',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Here\'s restaurant recommendations for you!'),
                ),
                _buildList(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
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
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantItem(
                restaurant: restaurant,
                isFavoritePage: false,
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit'),
            content: const Text('Do you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget _buildAndroid(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _buildHome(context),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildHome(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PreferenceProvider>(
          create: (_) => PreferenceProvider(
            preferenceHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
