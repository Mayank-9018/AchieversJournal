import 'package:flutter/material.dart';

enum Mode { frequency, duration }

class NewGoalPage3 extends StatefulWidget {
  final PageController _pageController;
  const NewGoalPage3(this._pageController, {Key? key}) : super(key: key);

  @override
  State<NewGoalPage3> createState() => _NewGoalPage3State();
}

class _NewGoalPage3State extends State<NewGoalPage3> {
  Mode _mode = Mode.duration;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget._pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
        );
        return false;
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 70),
        children: [
          ListTile(
            title: const Text('Frequency'),
            leading: Radio<Mode>(
              value: Mode.frequency,
              groupValue: _mode,
              onChanged: (value) {
                setState(() {
                  _mode = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                _mode = Mode.frequency;
              });
            },
          ),
          if (_mode == Mode.frequency)
            Padding(
              padding: const EdgeInsets.only(left: 75),
              child: Row(
                children: const [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: '10'),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'pages'),
                    ),
                  ),
                ],
              ),
            ),
          ListTile(
            title: const Text('Duration'),
            leading: Radio<Mode>(
              value: Mode.duration,
              groupValue: _mode,
              onChanged: (value) {
                setState(() {
                  _mode = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                _mode = Mode.duration;
              });
            },
          ),
          if (_mode == Mode.duration)
            Padding(
              padding: const EdgeInsets.only(left: 75),
              child: Row(
                children: const [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'hrs',
                        counterText: '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      ':',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'min',
                        counterText: '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
