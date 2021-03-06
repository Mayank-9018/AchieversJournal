import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/db_access.dart';
import '../models/new_goal.dart';
import '../pages/newgoal_page1.dart';
import '../pages/newgoal_page2.dart';
import '../pages/newgoal_page3.dart';
import '../pages/newgoal_page4.dart';

class NewGoalScreen extends StatefulWidget {
  const NewGoalScreen({Key? key}) : super(key: key);

  @override
  State<NewGoalScreen> createState() => _NewGoalScreenState();
}

class _NewGoalScreenState extends State<NewGoalScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => NewGoal(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set a new goal',
                style: Theme.of(context).textTheme.headline3,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    const NewGoalPage1(),
                    NewGoalPage2(_pageController),
                    NewGoalPage3(_pageController),
                    NewGoalPage4(_pageController)
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(currentPage == 3 ? 'Start' : 'Continue'),
                ),
                onPressed: () {
                  var newuser = Provider.of<NewGoal>(context, listen: false);
                  if (currentPage == 0 &&
                      (newuser.title == null || newuser.title!.trim() == '')) {
                    return;
                  } else if (currentPage == 2 &&
                      (newuser.currentGoal == 0 ||
                          (!newuser.isTimeBased &&
                              (newuser.unit == null ||
                                  newuser.unit!.trim() == '')))) {
                    return;
                  }
                  if (currentPage != 3) {
                    _pageController.animateToPage(
                      _pageController.page!.round() + 1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.fastOutSlowIn,
                    );
                  } else {
                    Provider.of<Database>(context, listen: false)
                        .addNewGoal(newuser.toMap());
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
