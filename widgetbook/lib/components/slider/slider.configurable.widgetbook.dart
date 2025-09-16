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
  final sliderType = context.knobs.list(
    label: 'Slider Type',
    options: [
      'base',
      'customVal',
    ],
    initialOption: 'base',
  );

  switch (sliderType) {
    case 'base':
      return BBSlider(
        type: BBSliderType.basic.name,
        onChanged: (value) => print(value.round()),
      );
    case 'customVal':
      return BBSlider(
        type: BBSliderType.customVal.name,
        onChanged: (value) => print(value.round()),
      );
  }

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
  @override
  Widget build(BuildContext context) {
    return BBSlider(
      type: BBSliderType.customVal.name,
      onChanged: (value) {
        print(value.round());
      },
    );
  }
}
