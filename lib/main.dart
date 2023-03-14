import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/ui/splash_page.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        appBarTheme: AppBarTheme(
          elevation: 0,
          toolbarTextStyle:
              myTextTheme.apply(bodyColor: Colors.black).bodyMedium,
          titleTextStyle: myTextTheme.apply(bodyColor: Colors.black).titleLarge,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(),
          ),
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
      ),
      navigatorKey: navigatorKey,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        HomePage.routeName: (context) => const HomePage(),
        FavoritePage.routeName: (context) => const FavoritePage(),
        SearchPage.routeName: (context) => const SearchPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant: ModalRoute.of(context)?.settings.arguments
                  as RestaurantElement,
            ),
      },
    );
  }
}

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.firaSans(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.firaSans(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.firaSans(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.firaSans(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall:
      GoogleFonts.firaSans(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.firaSans(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.firaSans(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.firaSans(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.lato(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.lato(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.lato(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.lato(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.lato(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
