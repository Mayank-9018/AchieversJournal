import 'package:achievers_journal/models/user.dart';
import 'package:achievers_journal/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:achievers_journal/screens/onboarding.dart';
import 'package:achievers_journal/themes/dark_theme.dart';
import 'package:achievers_journal/themes/light_theme.dart';
import 'models/db_access.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AJApp());
}

class AJApp extends StatelessWidget {
  const AJApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Database()),
        Provider(create: (context) => User()),
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          home: FutureBuilder<bool>(
            future: Provider.of<Database>(context).getSignInStatus(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User user = Provider.of<User>(context, listen: false);
                Database database =
                    Provider.of<Database>(context, listen: false);
                if (snapshot.data!) {
                  if (user.isSignedIn()) {
                    database.updateUserUID(user.userId);
                    return const DashboardScreen();
                  } else {
                    return const OnboardingScreen();
                  }
                } else {
                  if (database.hasCompletedOnboarding()) {
                    return const DashboardScreen();
                  } else {
                    return const OnboardingScreen();
                  }
                }
              } else {
                return const Scaffold();
              }
            },
          ),
        );
      },
    );
  }
}
