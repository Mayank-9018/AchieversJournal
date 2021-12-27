import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class NewGoalPage1 extends StatefulWidget {
  const NewGoalPage1({Key? key}) : super(key: key);

  @override
  State<NewGoalPage1> createState() => _NewGoalPage1State();
}

class _NewGoalPage1State extends State<NewGoalPage1> {
  IconData? _icon;

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
            const Flexible(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
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
                  _icon ?? Icons.do_not_disturb,
                  size: 28.0,
                  color: _icon == null ? Colors.grey : null,
                ),
              ),
            )
          ],
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

  void _pickIcon(BuildContext context) async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    _icon = icon;
    setState(() {});
  }
}
