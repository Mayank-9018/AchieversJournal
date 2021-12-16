import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  const PageIndicator(
      {required this.currentPage, required this.totalPages, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: getDots(),
    );
  }

  List<Widget> getDots() {
    List<Widget> dots = [];
    for (int i = 0; i < totalPages; i++) {
      dots.add(
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: i == currentPage ? Colors.blue.shade900 : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      );
      if (i != totalPages - 1) {
        dots.add(
          const SizedBox(
            width: 5,
          ),
        );
      }
    }
    return dots;
  }
}
