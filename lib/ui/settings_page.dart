import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/styles.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/platform_widget.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';
  final String username;

  const SettingsPage({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildSettings(BuildContext context) {
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
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Restaurant Reminder'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: scheduled.isScheduled,
                      onChanged: (value) async {
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
    return ChangeNotifierProvider(
      create: (_) => SchedulingProvider(),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
