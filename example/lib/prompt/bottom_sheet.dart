import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedBottomSheet extends StatefulWidget {
  const PromptedBottomSheet({super.key});

  @override
  State<PromptedBottomSheet> createState() => _PromptedBottomSheetState();
}

class _PromptedBottomSheetState extends State<PromptedBottomSheet> {
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
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Choice<String>.prompt(
          title: 'Categories',
          multiple: true,
          confirmation: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemSkip: (q, i) => !ChoiceFilter.test(choices[i], q),
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.filter?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModalHeader.createBuilder(
            automaticallyImplyLeading: false,
            actionsBuilder: [
              ChoiceConfirmButton.createBuilder(),
              ChoiceModal.createBuilder(
                child: const SizedBox(width: 20),
              ),
            ],
          ),
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
        ),
      ),
    );
  }
}
