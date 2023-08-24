import 'package:flutter/material.dart';
import 'package:choice_example/layout.dart';
import 'package:choice_example/sample.dart';
import 'chip.dart';
import 'radio.dart';
import 'checkbox.dart';
import 'switch.dart';
import 'composition.dart';

class ItemChoicePage extends StatelessWidget {
  const ItemChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Choice Item',
      children: <Widget>[
        SamplePanel(
          title: 'Chips Item',
          source: 'item/chip.dart',
          child: ItemChip(),
        ),
        SamplePanel(
          title: 'Radios Item',
          source: 'item/radio.dart',
          child: ItemRadio(),
        ),
        SamplePanel(
          title: 'Checkboxes Item',
          source: 'item/checkbox.dart',
          child: ItemCheckbox(),
        ),
        SamplePanel(
          title: 'Switches Item',
          source: 'item/switch.dart',
          child: ItemSwitch(),
        ),
        SamplePanel(
          title: 'Item Leading, Trailing, and Divider',
          source: 'item/composition.dart',
          child: ItemComposition(),
        ),
      ],
    );
  }
}
