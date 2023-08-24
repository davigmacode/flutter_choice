import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedConfirmation extends StatefulWidget {
  const PromptedConfirmation({super.key});

  @override
  State<PromptedConfirmation> createState() => _PromptedConfirmationState();
}

class _PromptedConfirmationState extends State<PromptedConfirmation> {
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

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.single(
                title: 'Category',
                confirmation: true,
                value: singleSelected,
                onChanged: setSingleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return RadioListTile(
                    value: choices[i],
                    groupValue: state.single,
                    onChanged: (value) {
                      state.select(choices[i]);
                    },
                    title: ChoiceText(
                      choices[i],
                      highlight: state.filter?.value,
                    ),
                  );
                },
                modalFooterBuilder: ChoiceModalFooter.createBuilder(
                  color: Colors.white,
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 7.0,
                  ),
                  children: [
                    (state) {
                      return TextButton(
                        onPressed: () => state.closeModal(confirmed: false),
                        child: const Text('Cancel'),
                      );
                    },
                    (state) {
                      return TextButton(
                        onPressed: () => state.closeModal(confirmed: true),
                        child: const Text('Submit'),
                      );
                    },
                  ],
                ),
                promptDelegate: ChoicePrompt.delegatePopupDialog(
                  maxHeightFactor: .5,
                  constraints: const BoxConstraints(maxWidth: 300),
                ),
                triggerBuilder: ChoiceTrigger.createBuilder(inline: true),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.multiple(
                title: 'Category',
                clearable: true,
                confirmation: true,
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
                listBuilder: ChoiceList.createWrapped(
                  padding: const EdgeInsets.all(20),
                  spacing: 10,
                  runSpacing: 10,
                ),
                modalHeaderBuilder: ChoiceModalHeader.createBuilder(
                  automaticallyImplyLeading: false,
                  actionsBuilder: [
                    ChoiceConfirmButton.createBuilder(),
                    ChoiceModal.createBuilder(
                      child: const SizedBox(width: 10),
                    ),
                  ],
                ),
                promptDelegate: ChoicePrompt.delegatePopupDialog(
                  constraints: const BoxConstraints(maxWidth: 400),
                ),
                triggerBuilder: ChoiceTrigger.createBuilder(valueTruncate: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
