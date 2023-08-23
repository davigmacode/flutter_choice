import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class ItemSwitch extends StatefulWidget {
  const ItemSwitch({super.key});

  @override
  State<ItemSwitch> createState() => _ItemSwitchState();
}

class _ItemSwitchState extends State<ItemSwitch> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];
  String? singleSelected;
  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InlineChoice<String>(
        multiple: true,
        clearable: true,
        value: multipleSelected,
        onChanged: setMultipleSelected,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return SwitchListTile(
            value: state.selected(choices[i]),
            onChanged: state.onSelected(choices[i]),
            title: Text(choices[i]),
          );
        },
        listBuilder: ChoiceList.createVirtualized(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}
