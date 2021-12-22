import 'package:flutter/material.dart';

class NewGoalPage4 extends StatelessWidget {
  final PageController _pageController;
  const NewGoalPage4(this._pageController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
