import 'package:flutter/material.dart';

class DateCircle extends StatelessWidget {
  final String dateString;
  final DateTime date;
  DateCircle(this.dateString, {Key? key})
      : date = DateTime.parse(dateString),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.day.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            months.elementAt(date.month - 1),
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

Set<String> months = {
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
};
