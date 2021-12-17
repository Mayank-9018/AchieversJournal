import 'package:flutter/material.dart';

enum Frequency { daily, weekly }

class NewGoalPage2 extends StatefulWidget {
  const NewGoalPage2({Key? key}) : super(key: key);

  @override
  State<NewGoalPage2> createState() => _NewGoalPage2State();
}

class _NewGoalPage2State extends State<NewGoalPage2> {
  Frequency _frequency = Frequency.daily;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 50),
      children: [
        Text(
          "How often?",
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          height: 50,
        ),
        ListTile(
          title: const Text('Everyday'),
          leading: Radio<Frequency>(
            value: Frequency.daily,
            groupValue: _frequency,
            onChanged: (value) {
              setState(() {
                _frequency = value!;
              });
            },
          ),
          onTap: () {
            setState(() {
              _frequency = Frequency.daily;
            });
          },
        ),
        ListTile(
          title: const Text('Weekly'),
          leading: Radio<Frequency>(
            value: Frequency.weekly,
            groupValue: _frequency,
            onChanged: (value) {
              setState(() {
                _frequency = value!;
              });
            },
          ),
          onTap: () {
            setState(() {
              _frequency = Frequency.weekly;
            });
          },
        ),
      ],
    );
  }
}
