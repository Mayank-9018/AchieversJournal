import 'package:flutter/material.dart';

class WeeklyAnalysis extends StatelessWidget {
  final List<double> values;

  const WeeklyAnalysis(this.values, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 10.0, spreadRadius: 0.0)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _getBars(),
      ),
    );
  }

  List<Widget> _getBars() {
    List<Widget> bars = [];
    for (double val in values) {
      bars.add(
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: val),
          duration: const Duration(seconds: 1),
          curve: Curves.easeOutBack,
          builder: (context, value, child) => Container(
            width: 10,
            height: 150 * value,
            decoration: BoxDecoration(
              color: val >= 0.7
                  ? Colors.green
                  : val > 0.3
                      ? Colors.amber
                      : Colors.red,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      );
    }
    return bars;
  }
}
