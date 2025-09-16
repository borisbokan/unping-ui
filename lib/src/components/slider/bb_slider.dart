import 'package:flutter/material.dart';

enum BBSliderType {
  basic,
  customVal,
}

class BBSlider extends StatefulWidget {
  BBSlider({super.key, required this.onChanged, this.type});
  String? type = 'basic';
  final ValueChanged<double> onChanged;

  @override
  State<BBSlider> createState() => _BBSliderState();
}

class _BBSliderState extends State<BBSlider> {
  // Visuals
  static const double _trackWidth = 200.0;
  static const double _knobSize = 20.00;

  // Current knob X in pixels (0..usable) and mapped value (0..200)
  double _knobX = 0.0;

  TextEditingController _valueCtrl = TextEditingController();

  double _usable = _trackWidth - _knobSize;

  // Logical values
  static const double _minVal = 0.0;
  static const double _maxVal = 200.0;

  //double get getValue => _value ;
  double _value = 0.0;

  bool _msgVisible = false;

  String? _message;

  @override
  void initState() {
    super.initState();
    _value = _minVal + (_knobX / _usable) * (_maxVal - _minVal);
    _valueCtrl.text = _knobX.toString();
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Init value

    return Center(
      child: SizedBox(
        // Give the Stack room so the knob stays inside hit area at both ends
        width: _trackWidth,
        height: 120,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Min label (left outside a bit if you want)
            const Positioned(
              left: -30,
              top: 18,
              child: Text("0",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
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
            Positioned(
              right: -40,
              top: 18,
              child: Text("${_maxVal.toString()}",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),

            // Current value above knob
            Positioned(
              top: -10,
              left: _knobX,
              child: Text(
                _value.round().toString(),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            Visibility(
                visible:
                    widget.type == BBSliderType.customVal.name ? true : false,
                child: Positioned(
                  height: 40,
                  width: 120,
                  bottom: 37,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      // if (mounted)
                      //   setState(() {
                      //     if (v.isEmpty) {
                      //       _knobX = 0.0;
                      //     }
                      //     _knobX = (double.parse(v).clamp(0.0, _usable!));
                      //   });
                    },
                    onEditingComplete: () {
                      if (_valueCtrl.text.length > 0) {
                        double parVal = double.parse(_valueCtrl.text);
                        setState(() {
                          if (parVal > 0 && parVal < 201) {
                            _value = parVal;
                            _knobX = _value.clamp(0.0, _usable);
                            _msgVisible = false;
                          } else {
                            _msgVisible = true;
                            _message =
                                "You exceeded the set max value of ${_maxVal.toString()} you entered ${_valueCtrl.text}";
                          }
                        });
                      }
                    },
                    textAlign: TextAlign.center,
                    controller: _valueCtrl,
                  ),
                )),
            //Message box
            Visibility(
              visible: _msgVisible,
              child: Positioned(
                bottom: 15,
                child: Text(
                  _message ?? "",
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),

            // Knob (draggable only on X)
            Positioned(
              left: _knobX,
              top: 18,
              child: GestureDetector(
                onPanUpdate: (d) {
                  setState(() {
                    _value = _minVal + (_knobX / _usable) * (_maxVal - _minVal);
                    // Clamp to [0, usable] where usable = trackWidth - knobSize
                    _knobX = (_knobX + d.delta.dx).clamp(0.0, _usable);
                  });
                  _valueCtrl.text = (_value).round().toString();
                  widget.onChanged(_knobX);
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
      ),
    );
  }
}
