import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedSearchable extends StatefulWidget {
  const PromptedSearchable({super.key});

  @override
  State<PromptedSearchable> createState() => _PromptedSearchableState();
}

class _PromptedSearchableState extends State<PromptedSearchable> {
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
                searchable: true,
                confirmation: true,
                value: singleSelected,
                onChanged: setSingleSelected,
                itemCount: choices.length,
                itemSkip: (state, i) =>
                    !ChoiceSearch.match(choices[i], state.search?.value),
                itemBuilder: (state, i) {
                  return RadioListTile(
                    value: choices[i],
                    groupValue: state.single,
                    onChanged: (value) {
                      state.select(choices[i]);
                    },
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                modalHeaderBuilder: ChoiceModal.createHeader(
                  automaticallyImplyLeading: false,
                  actionsBuilder: [
                    ChoiceModal.createSpacer(width: 5),
                  ],
                ),
                modalFooterBuilder: ChoiceModal.createFooter(
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
                  maxHeightFactor: .7,
                  constraints: const BoxConstraints(maxWidth: 300),
                ),
                anchorBuilder: ChoiceAnchor.create(inline: true),
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
                searchable: true,
                value: multipleSelected,
                onChanged: setMultipleSelected,
                itemCount: choices.length,
                itemSkip: (state, i) =>
                    !ChoiceSearch.match(choices[i], state.search?.value),
                itemBuilder: (state, i) {
                  return ChoiceChip(
                    selected: state.selected(choices[i]),
                    onSelected: state.onSelected(choices[i]),
                    label: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(
                  padding: const EdgeInsets.all(20),
                  spacing: 10,
                  runSpacing: 10,
                ),
                modalHeaderBuilder: ChoiceModal.createHeader(
                  automaticallyImplyLeading: false,
                  actionsBuilder: [
                    ChoiceModal.createConfirmButton(),
                    ChoiceModal.createSpacer(width: 10),
                  ],
                ),
                promptDelegate: ChoicePrompt.delegatePopupDialog(
                  constraints: const BoxConstraints(maxWidth: 400),
                ),
                anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
