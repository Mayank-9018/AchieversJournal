import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final IconData icon;
  final String goal;
  final int progress;

  const ProgressBar(this.icon, this.goal, this.progress, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.5),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.only(top: 1.5, left: 1.5),
            child: Container(
              height: 70 - 3.0,
              width: (constraints.maxWidth * progress / 100) - 3.0,
              decoration: BoxDecoration(
                color: progress > 70
                    ? Colors.green
                    : progress > 30
                        ? Colors.amber
                        : Colors.red,
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.5,
          left: 10,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(
                icon,
                size: 35,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                goal,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        )
      ],
    );
  }
}
