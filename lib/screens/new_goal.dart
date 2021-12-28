import 'package:achievers_journal/models/new_goal.dart';
import 'package:achievers_journal/pages/newgoal_page1.dart';
import 'package:achievers_journal/pages/newgoal_page2.dart';
import 'package:achievers_journal/pages/newgoal_page3.dart';
import 'package:achievers_journal/pages/newgoal_page4.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, -2),
                  blurRadius: 10.0,
                  spreadRadius: 1),
            ],
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
