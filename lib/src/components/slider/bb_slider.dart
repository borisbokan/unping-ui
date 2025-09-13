import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class BBSlider extends StatefulWidget {
  const BBSlider({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<double> onChanged;

  @override
  State<BBSlider> createState() => _BBSliderState();
}

class _BBSliderState extends State<BBSlider> {
  // Visuals
  static const double _trackWidth = 200.0;
  static const double _knobSize = 20.0;

  // Logical values
  static const double _minVal = 0.0;
  static const double _maxVal = 200.0;

  // Current knob X in pixels (0..usable) and mapped value (0..200)
  double _knobX = 0.0;

  double get _usable => _trackWidth - _knobSize;

  double get _value => _minVal + (_knobX / _usable) * (_maxVal - _minVal);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Give the Stack room so the knob stays inside hit area at both ends
      width: _trackWidth,
      height: 60,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Min label (left outside a bit if you want)
          const Positioned(
            left: -30,
            top: 18,
            child:
                Text('0', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),

          // Track centered
          Positioned(
            left: 0,
            right: 0,
            top: 28,
            child: SizedBox(
              width: _trackWidth,
              height: 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),

          // Max label
          const Positioned(
            right: -37,
            top: 18,
            child: Text('200',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),

          // Current value above knob
          Positioned(
            top: 0,
            left: _knobX,
            child: Text(
              _value.round().toString(),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),

          // Knob (draggable only on X)
          Positioned(
            left: _knobX,
            top: 18,
            child: GestureDetector(
              onPanUpdate: (d) {
                setState(() {
                  // Clamp to [0, usable] where usable = trackWidth - knobSize
                  _knobX = (_knobX + d.delta.dx).clamp(0.0, _usable);
                });
                widget.onChanged(_value);
              },
              child: Container(
                height: _knobSize,
                width: _knobSize,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(_knobSize),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
