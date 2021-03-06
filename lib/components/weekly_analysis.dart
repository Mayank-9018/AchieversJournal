import 'package:flutter/material.dart';

class WeeklyAnalysis extends StatelessWidget {
  final List<double> values;
  final bool isLandscape;

  const WeeklyAnalysis(this.values, {this.isLandscape = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: isLandscape ? 20 : 0, top: 20, bottom: isLandscape ? 20 : 0),
      child: Container(
        width: isLandscape
            ? MediaQuery.of(context).size.width * 0.75
            : MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade300
                  : Colors.grey.shade800,
              blurRadius: 15.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 30),
              child: Text(
                'Weekly Analysis',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 22.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                bottom: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _getBars(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getBars(context) {
    List<Widget> bars = [];
    for (double val in values) {
      bars.add(
        TweenAnimationBuilder<double>(
          child: Container(
            width: 10,
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.grey.shade700,
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
