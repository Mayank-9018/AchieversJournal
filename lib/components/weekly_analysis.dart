import 'package:flutter/material.dart';

class WeeklyAnalysis extends StatelessWidget {
  final List<double> values;

  const WeeklyAnalysis(this.values, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 10.0, spreadRadius: 0.0)
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.0,
            top: 20.0,
            child: Text(
              'Weekly Analysis',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 22.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                bottom: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _getBars(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getBars() {
    List<Widget> bars = [];
    for (double val in values) {
      bars.add(
        TweenAnimationBuilder<double>(
          child: Container(
            width: 10,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade50,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          tween: Tween<double>(begin: 0.0, end: val),
          duration: const Duration(seconds: 1),
          curve: const Interval(
            0.20,
            1.0,
            curve: Curves.easeOutBack,
          ),
          builder: (context, value, child) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              child!,
              Container(
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
            ],
          ),
        ),
      );
    }
    return bars;
  }
}
