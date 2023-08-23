import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class ItemComposition extends StatefulWidget {
  const ItemComposition({super.key});

  @override
  State<ItemComposition> createState() => _ItemCompositionState();
}

class _ItemCompositionState extends State<ItemComposition> {
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
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: multipleSelected,
      onChanged: setMultipleSelected,
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      leadingBuilder: (state) {
        return ChoiceChip(
          selected: state.selectedMany(choices) ?? false,
          onSelected: state.onSelectedMany(choices),
          label: const Text('All'),
        );
      },
      trailingBuilder: (state) {
        return IconButton(
          tooltip: 'Add Choice',
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => setState(
            () => choices.add('Opt #${choices.length + 1}'),
          ),
        );
      },
      dividerBuilder: (state) {
        return const Text('-');
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}
