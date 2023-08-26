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
          modalHeaderBuilder: ChoiceModalHeader.createBuilder(
            automaticallyImplyLeading: false,
            actionsBuilder: [
              ChoiceConfirmButton.createBuilder(),
              ChoiceModal.createBuilder(
                child: const SizedBox(width: 20),
              ),
            ],
          ),
          modalSeparatorBuilder: ChoiceModalSeparator.createBuilder(),
          modalFooterBuilder: (state) {
            return Container(
              color: Colors.white,
              child: CheckboxListTile(
                value: state.selectedMany(choices),
                onChanged: state.onSelectedMany(choices),
                tristate: true,
                title: const Text('Select All'),
              ),
            );
          },
          listBuilder: ChoiceList.createGrid(childAspectRatio: 1 / .25),
          triggerBuilder: ChoiceTrigger.createBuilder(),
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
        ),
      ),
    );
  }
}
