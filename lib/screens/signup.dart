import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text(
              'Create a new account',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: 25,
            ),
            const TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email address'),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
