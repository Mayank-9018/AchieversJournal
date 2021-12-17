import 'package:achievers_journal/pages/newgoal_page1.dart';
import 'package:achievers_journal/pages/newgoal_page2.dart';
import 'package:achievers_journal/pages/newgoal_page3.dart';
import 'package:flutter/material.dart';

class NewGoalScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  NewGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                children: const [
                  NewGoalPage1(),
                  NewGoalPage2(),
                  NewGoalPage3()
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Continue'),
              ),
              onPressed: () {
                if (_pageController.page!.round() != 3) {
                  _pageController.jumpToPage(_pageController.page!.round() + 1);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
