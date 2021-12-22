import 'package:flutter/material.dart';

class NewGoalPage1 extends StatelessWidget {
  const NewGoalPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 50),
      children: [
        Text(
          "What's your goal?",
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 50,
        ),
        const TextField(
          decoration: InputDecoration(
            hintText: 'Title',
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const TextField(
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'Description(optional)',
          ),
        ),
      ],
    );
  }
}
