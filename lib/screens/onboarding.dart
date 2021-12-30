import 'package:achievers_journal/models/user.dart';
import 'package:achievers_journal/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/onboarding_page1.dart';
import '/pages/onboarding_page2.dart';
import '/pages/onboarding_page3.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: const [
                OnboardingPage1(),
                OnboardingPage2(),
                OnboardingPage3(),
              ],
            ),
          ),
          Container(
            height: 75,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, -2),
                    blurRadius: 10.0,
                    spreadRadius: 1),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            vertical: 17.0,
                            horizontal: 15.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<User>(context, listen: false)
                            .signInWithGoogle()
                            .then(
                          (value) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
                                ),
                                (route) => false);
                          },
                        );
                      },
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google_sign_in_logo.png',
                              width: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Sign in with Google',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                            (route) => false);
                      },
                      child: const FittedBox(
                        child: Text(
                          'Continue without Login',
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
