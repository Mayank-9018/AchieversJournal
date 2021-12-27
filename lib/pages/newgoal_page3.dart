import 'package:achievers_journal/models/new_goal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Mode { frequency, duration }

class NewGoalPage3 extends StatefulWidget {
  final PageController _pageController;
  const NewGoalPage3(this._pageController, {Key? key}) : super(key: key);

  @override
  State<NewGoalPage3> createState() => _NewGoalPage3State();
}

class _NewGoalPage3State extends State<NewGoalPage3> {
  Mode? _mode;
  late final NewGoal newGoal;
  late final TextEditingController goalController;
  late final TextEditingController unitController;

  @override
  void initState() {
    super.initState();
    newGoal = Provider.of<NewGoal>(context, listen: false);
    _mode = newGoal.isTimeBased ? Mode.duration : Mode.frequency;
    goalController =
        TextEditingController(text: newGoal.currentGoal.toString());
    unitController = TextEditingController(text: newGoal.unit);
  }

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
                  newGoal.isTimeBased = false;
                });
              },
            ),
            onTap: () {
              setState(() {
                _mode = Mode.frequency;
                newGoal.isTimeBased = false;
              });
            },
          ),
          if (_mode == Mode.frequency)
            Padding(
              padding: const EdgeInsets.only(left: 75),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: goalController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(hintText: '10'),
                      onChanged: (value) {
                        newGoal.currentGoal = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: unitController,
                      decoration: const InputDecoration(hintText: 'pages'),
                      onChanged: (value) {
                        newGoal.unit = value;
                      },
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
                  newGoal.isTimeBased = true;
                  newGoal.unit = null;
                });
              },
            ),
            onTap: () {
              setState(() {
                _mode = Mode.duration;
                newGoal.isTimeBased = true;
                newGoal.unit = null;
              });
            },
          ),
          if (_mode == Mode.duration)
            Padding(
              padding: const EdgeInsets.only(left: 75),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: goalController,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: '30',
                        counterText: '',
                      ),
                      onChanged: (value) {
                        newGoal.currentGoal = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'minutes',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
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
