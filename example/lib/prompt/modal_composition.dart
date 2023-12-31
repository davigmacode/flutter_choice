import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedModal extends StatefulWidget {
  const PromptedModal({super.key});

  @override
  State<PromptedModal> createState() => _PromptedModalState();
}

class _PromptedModalState extends State<PromptedModal> {
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

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
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
          clearable: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.search?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModal.createHeader(
            automaticallyImplyLeading: false,
            actionsBuilder: [
              ChoiceModal.createConfirmButton(),
              ChoiceModal.createSpacer(width: 20),
            ],
          ),
          modalSeparatorBuilder: ChoiceModal.createSeparator(),
          modalFooterBuilder: (state) {
            return CheckboxListTile(
              value: state.selectedMany(choices),
              onChanged: state.onSelectedMany(choices),
              tristate: true,
              title: const Text('Select All'),
            );
          },
          listBuilder: ChoiceList.createGrid(childAspectRatio: 1 / .25),
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
          anchorBuilder: ChoiceAnchor.create(),
        ),
      ),
    );
  }
}
