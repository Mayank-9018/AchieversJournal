import 'package:flutter/material.dart';

enum Frequency { daily, weekly }

class NewGoalPage2 extends StatefulWidget {
  final PageController _pageController;
  const NewGoalPage2(this._pageController, {Key? key}) : super(key: key);

  @override
  State<NewGoalPage2> createState() => _NewGoalPage2State();
}

class _NewGoalPage2State extends State<NewGoalPage2> {
  Frequency _frequency = Frequency.daily;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget._pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
        );
        return false;
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 50),
        children: [
          Text(
            'How often?',
            style: Theme.of(context).textTheme.headline5,
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
            enabled: false,
            title: const Text('Weekly (Coming Soon)'),
            leading: Radio<Frequency>(  
              value: Frequency.weekly,
              groupValue: _frequency,
              onChanged: (value) {
                // setState(() {
                //   _frequency = value!;
                // });
              },
            ),
            onTap: () {
              setState(() {
                _frequency = Frequency.weekly;
              });
            },
          ),
        ],
      ),
    );
  }
}
