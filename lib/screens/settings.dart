import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/db_access.dart';
import '../models/user.dart';
import 'onboarding.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Settings',
                style: Theme.of(context).brightness == Brightness.light
                    ? const TextStyle(color: Colors.black)
                    : null,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                ListTile(
                  title: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  subtitle: const Text(
                      'Sign in with Google to sync data between devices.'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Theme mode',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  subtitle: const Text('Current: System'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                  onTap: () {
                    Provider.of<User>(context, listen: false).logout();
                    Provider.of<Database>(context, listen: false)
                      ..updateCompletedOnboardingStatus(false)
                      ..updateSignInStatus(false);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                        (route) => false);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
