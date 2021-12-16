import 'package:flutter/material.dart';

class NotificationDemo extends StatelessWidget {
  const NotificationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 22.5,
                    ),
                    const Text('Achivers Journal • now'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 45.0,
                  top: 8.0,
                  bottom: 20,
                ),
                child: Text(
                  'Time to meditate.',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 27.5,
          left: 15.0,
          child: Icon(
            Icons.self_improvement,
            size: 40.0,
          ),
        )
      ],
    );
  }
}
