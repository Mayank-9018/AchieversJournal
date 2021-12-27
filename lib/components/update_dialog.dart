import 'package:flutter/material.dart';
import 'custom_slider_thumb.dart';

class UpdateDialog extends StatefulWidget {
  final Map<dynamic, dynamic> track;
  final void Function(int) updateAchieved;
  const UpdateDialog(this.track, this.updateAchieved, {Key? key})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  double sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.track['achieved'].toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Update Goal'),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          height: 60,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: getColors(),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const Text(
                '0',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 4,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade400,
                    tickMarkShape: SliderTickMarkShape.noTickMark,
                    thumbColor: getColors(text: true),
                    overlayColor: Colors.white.withOpacity(0.3),
                    thumbShape: CustomSliderThumb(
                      18.0,
                      max: widget.track['goal'].toDouble(),
                    ),
                  ),
                  child: Slider(
                    value: sliderValue,
                    min: 0.0,
                    max: widget.track['goal'].toDouble(),
                    divisions: widget.track['goal'],
                    onChanged: (val) {
                      setState(
                        () {
                          sliderValue = val;
                        },
                      );
                    },
                  ),
                ),
              ),
              Text(
                widget.track['goal'].toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 60,
            right: 60,
          ),
          child: ElevatedButton(
            onPressed: () {
              widget.updateAchieved(sliderValue.toInt());
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        )
      ],
    );
  }

  dynamic getColors({bool text = false}) {
    double val = sliderValue / widget.track['goal'];
    if (text) {
      if (val >= 0.7) {
        return Colors.green;
      } else if (val > 0.3) {
        return Colors.amber;
      } else {
        return Colors.red;
      }
    } else {
      if (val >= 0.7) {
        return [
          Colors.green.shade300,
          Colors.green.shade600,
        ];
      } else if (val > 0.3) {
        return [
          Colors.orange.shade300,
          Colors.orange.shade600,
        ];
      } else {
        return [
          Colors.red.shade300,
          Colors.red.shade600,
        ];
      }
    }
  }
}
