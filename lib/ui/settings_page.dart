import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles.dart';
import '../data/preference/preference_helper.dart';
import '../provider/preference_provider.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/platform_widget.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';

  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildSettings(BuildContext context) {
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
                    'Settings',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Material(
                  child: ListTile(
                    title: const Text('Restaurant Reminder'),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: provider.isDailyReminderActive,
                          onChanged: (value) async {
                            provider.setDailyReminder(value);
                            if (Platform.isIOS) {
                              customDialog(context);
                            } else {
                              scheduled.scheduledNotification(value);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildSettings(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildSettings(context),
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
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
      ],
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
