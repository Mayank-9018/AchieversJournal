import 'package:flutter/material.dart';

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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
