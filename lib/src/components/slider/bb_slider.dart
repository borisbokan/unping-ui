import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class BBSlider extends StatefulWidget {
  const BBSlider({
    super.key,
    this.min = 0,
    this.max = 200,
    required this.value,
    required this.onChanged,
    this.height = 56,
    this.trackHeight = 6,
    this.handleRadius = 12,
    this.paddingHorizontal = 36, // space for min/max labels
  });

  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;

  final double height;
  final double trackHeight;
  final double handleRadius;
  final double paddingHorizontal;

  @override
  State<BBSlider> createState() => _BBSliderState();
}

class _BBSliderState extends State<BBSlider> {
  dynamic _minVal;
  dynamic _maxVal;
  dynamic _currentValue;

  @override
  void initState() {
    super.initState();

    _currentValue = 25;
  }

  @override
  void didUpdateWidget(covariant BBSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When parent value changes, update px position on next build with LayoutBuilder
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (builder, constraint) {
        return Stack(
          alignment: AlignmentGeometry.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -30,
              child: Text(
                _minVal ?? 0.toString(),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Positioned(
              child: Container(
                width: 200,
                height: 3,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: _currentValue ?? 0,
              top: -7,
              bottom: -7,
              child: GestureDetector(
                onPanUpdate: (d) {
                  setState(() {
                    _currentValue =
                        (_currentValue + d.delta.dx).clamp(0.0, 200);
                  });
                },
                child: Container(
                    key: Key("xway"),
                    height: 15,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[600])),
              ),
            ),
            Positioned(
              top: -30,
              left: _currentValue,
              child: Text("${_currentValue.round()}",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            Positioned(
              right: -30,
              child: Text(
                _maxVal ?? 200.toString(),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
