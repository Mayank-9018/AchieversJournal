import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';

import '../models/db_access.dart';
import '../models/goal.dart';
import '../pages/newgoal_page2.dart' show Frequency;
import '../pages/newgoal_page3.dart' show Mode;

class GoalEditDialog extends StatefulWidget {
  final Goal goal;

  const GoalEditDialog(this.goal, {Key? key}) : super(key: key);

  @override
  State<GoalEditDialog> createState() => _GoalEditDialogState();
}

class _GoalEditDialogState extends State<GoalEditDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  late Mode mode;
  int? icon;
  Widget spacing = const SizedBox(height: 10);

  @override
  void initState() {
    titleController.text = widget.goal.name;
    icon = widget.goal.icon;
    descriptionController.text = widget.goal.description ?? '';
    mode = widget.goal.isTimeBased ? Mode.duration : Mode.frequency;
    goalController.text = widget.goal.currentGoal!.toString();
    if (mode == Mode.frequency) {
      unitController.text = widget.goal.unit!;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    goalController.dispose();
    unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit goal'),
        actions: [
          TextButton(onPressed: validate, child: const Text('Save')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
        children: [
          Text(
            'Title:',
            style: Theme.of(context).textTheme.headline6,
          ),
          spacing,
          Row(
            children: [
              Flexible(
                child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    onChanged: (value) {}
                    // },
                    ),
              ),
              const SizedBox(
                width: 10,
              ),
              Tooltip(
                message: 'Add Icon',
                child: InkWell(
                  borderRadius: BorderRadius.circular(14.0),
                  onTap: () => _pickIcon(context),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Icon(
                      icon == null
                          ? Icons.do_not_disturb
                          : IconData(
                              icon!,
                              fontFamily: 'MaterialIcons',
                            ),
                      size: 28.0,
                      color: icon == null ? Colors.grey : null,
                    ),
                  ),
                ),
              )
            ],
          ),
          spacing,
          Text(
            'Description:',
            style: Theme.of(context).textTheme.headline6,
          ),
          spacing,
          TextField(
            controller: descriptionController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Description(optional)',
            ),
          ),
          spacing,
          Text(
            'Frequency:',
            style: Theme.of(context).textTheme.headline6,
          ),
          spacing,
          ListTile(
            title: const Text('Everyday'),
            leading: Radio<Frequency>(
              value: Frequency.daily,
              groupValue: Frequency.daily,
              onChanged: (value) {},
            ),
          ),
          spacing,
          Text(
            'Mode:',
            style: Theme.of(context).textTheme.headline6,
          ),
          spacing,
          ListTile(
            title: const Text('Frequency'),
            leading: Radio<Mode>(
              value: Mode.frequency,
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                mode = Mode.frequency;
              });
            },
          ),
          if (mode == Mode.frequency)
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
                    ),
                  ),
                ],
              ),
            ),
          ListTile(
            title: const Text('Duration'),
            leading: Radio<Mode>(
              value: Mode.duration,
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode = value!;
                });
              },
            ),
            onTap: () {
              setState(() {
                mode = Mode.duration;
              });
            },
          ),
          if (mode == Mode.duration)
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

  void _pickIcon(BuildContext context) async {
    IconData? newIcon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [IconPack.material],
    );
    icon = newIcon?.codePoint;
    setState(() {});
  }

  void saveChanges() {
    Map<String, dynamic> changes = {};
    if (widget.goal.name != titleController.text) {
      changes['name'] = titleController.text;
    }
    if (widget.goal.icon != icon) {
      changes['icon'] = icon;
    }
    if ((widget.goal.description ?? '') != descriptionController.text) {
      changes['description'] = descriptionController.text;
    }
    if (!widget.goal.isTimeBased && (unitController.text != widget.goal.unit)) {
      changes['unit'] = unitController.text;
    }
    if (widget.goal.isTimeBased == (mode != Mode.duration)) {
      changes['isTimeBased'] = mode == Mode.duration;
      changes['unit'] =
          changes['isTimeBased'] as bool ? null : unitController.text;
    }
    if (widget.goal.currentGoal != int.parse(goalController.text)) {
      changes['currentGoal'] = int.parse(goalController.text);
    }
    if (changes.isNotEmpty) {
      Provider.of<Database>(context, listen: false)
          .updateGoal(widget.goal.position!, changes);
    }
    Navigator.of(context).pop();
  }

  void validate() {
    if (titleController.text.trim().isNotEmpty) {
      if (goalController.text.trim().isNotEmpty) {
        if (mode == Mode.frequency) {
          if (unitController.text.trim().isNotEmpty) {
            saveChanges();
          } else {
            showErrorSnackBar('Unit cannot be empty');
          }
        } else {
          saveChanges();
        }
      } else {
        showErrorSnackBar('Goal cannot be empty');
      }
    } else {
      showErrorSnackBar('Goal title cannot be empty');
    }
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
