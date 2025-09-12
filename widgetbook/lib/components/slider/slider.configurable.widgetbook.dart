import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

@widgetbook.UseCase(
  name: 'ConfigurableSlider',
  type: BBSlider,
  path: 'Components/Slider/Configurable',
)
Widget buildConfigurableSlider(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Slider', 'Configurable'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: _ConfigurableSlider(),
          ),
        ])
      ],
    ),
  );
}

class _ConfigurableSlider extends StatefulWidget {
  @override
  State<_ConfigurableSlider> createState() => _ConfigurableSliderState();
}

class _ConfigurableSliderState extends State<_ConfigurableSlider> {
  double _sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return BBSlider(
      value: _sliderValue,
      onChanged: (value) {
        setState(() {
          _sliderValue = value;
        });
      },
    );
  }
}
