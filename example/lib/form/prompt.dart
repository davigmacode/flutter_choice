import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class FormPrompt extends StatefulWidget {
  const FormPrompt({super.key});

  @override
  State<FormPrompt> createState() => _FormPromptState();
}

class _FormPromptState extends State<FormPrompt> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();

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

  String? selectedValue;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormField<String>(
            autovalidateMode: AutovalidateMode.always,
            initialValue: selectedValue,
            onSaved: setSelectedValue,
            validator: (value) {
              if (value?.isEmpty ?? value == null) {
                return 'Please select a category';
              }
              return null;
            },
            builder: (formState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: PromptedChoice<String>.single(
                        title: 'Category',
                        value: formState.value,
                        onChanged: (val) => formState.didChange(val),
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
                              highlight: state.search?.value,
                            ),
                          );
                        },
                        promptDelegate: ChoicePrompt.delegatePopupDialog(
                          maxHeightFactor: .5,
                          constraints: const BoxConstraints(maxWidth: 300),
                        ),
                        anchorBuilder: ChoiceAnchor.create(
                          inline: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formState.errorText ?? '${formState.value} selected',
                      style: TextStyle(
                        color: formState.hasError
                            ? Colors.redAccent
                            : Colors.green,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Submitted Value:'),
                      const SizedBox(height: 5),
                      Text(selectedValue.toString())
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (formKey.currentState!.validate()) {
                      // If the form is valid, save the value.
                      formKey.currentState!.save();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
