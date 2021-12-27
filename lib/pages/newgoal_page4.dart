import 'package:achievers_journal/models/new_goal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewGoalPage4 extends StatelessWidget {
  final PageController _pageController;
  const NewGoalPage4(this._pageController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGoal newGoal = Provider.of<NewGoal>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        _pageController.animateToPage(
          2,
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
        );
        return false;
      },
      child: ListView(
        padding: const EdgeInsets.only(top: 70),
        children: [
          Text(
            'Goal Summary',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              newGoal.iconData == null
                  ? Container()
                  : Icon(
                      IconData(newGoal.iconData!, fontFamily: 'MaterialIcons'),
                      size: 40.0,
                    ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                newGoal.title!,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: newGoal.iconData == null ? 15 : 55,
            ),
            child: Text(
              newGoal.description ?? '',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: newGoal.iconData == null ? 15 : 55,
            ),
            child: newGoal.isTimeBased
                ? Text('${newGoal.currentGoal} minutes')
                : Text('${newGoal.currentGoal} ${newGoal.unit}'),
          )
        ],
      ),
    );
  }
}
