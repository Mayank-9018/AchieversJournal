import 'package:achievers_journal/models/new_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';

class NewGoalPage1 extends StatefulWidget {
  const NewGoalPage1({Key? key}) : super(key: key);

  @override
  State<NewGoalPage1> createState() => _NewGoalPage1State();
}

class _NewGoalPage1State extends State<NewGoalPage1> {
  late final NewGoal newGoal;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    newGoal = Provider.of<NewGoal>(context, listen: false);
    titleController = TextEditingController(text: newGoal.title);
    descriptionController = TextEditingController(text: newGoal.description);
  }

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
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                onChanged: (value) => newGoal.title = value,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(14.0),
              onTap: () => _pickIcon(context),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  newGoal.iconData == null
                      ? Icons.do_not_disturb
                      : IconData(
                          newGoal.iconData!,
                          fontFamily: 'MaterialIcons',
                        ),
                  size: 28.0,
                  color: newGoal.iconData == null ? Colors.grey : null,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: descriptionController,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: 'Description(optional)',
          ),
          onChanged: (value) => newGoal.description = value,
        ),
      ],
    );
  }

  void _pickIcon(BuildContext context) async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    newGoal.iconData = icon?.codePoint;
    setState(() {});
  }
}
