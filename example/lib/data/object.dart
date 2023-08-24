import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

class DataObject extends StatefulWidget {
  const DataObject({super.key});

  @override
  State<DataObject> createState() => _DataObjectState();
}

class _DataObjectState extends State<DataObject> {
  List<ChoiceData<String>> choicesValue = [];
  final choicesMemoizer = AsyncMemoizer<List<ChoiceData<String>>>();

  void setChoicesValue(List<ChoiceData<String>> value) {
    setState(() => choicesValue = value);
  }

  Future<List<ChoiceData<String>>> getChoices() async {
    try {
      const url =
          "https://randomuser.me/api/?inc=name,picture,email&results=25";
      final res = await Dio().get(url);
      final data = res.data['results'] as List;
      return Future.value(data.asChoiceData(
        value: (i, e) => e['email'],
        title: (i, e) => e['name']['first'] + ' ' + e['name']['last'],
        image: (i, e) => e['picture']['thumbnail'],
      ));
    } on DioException catch (e) {
      throw ErrorDescription(e.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChoiceData<String>>>(
      initialData: const [],
      future: choicesMemoizer.runOnce(getChoices),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(25),
            constraints: const BoxConstraints(maxHeight: 200),
            child: Text(
              snapshot.error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return SizedBox(
          width: 300,
          child: Card(
            child: PromptedChoice<ChoiceData<String>>.multiple(
              title: 'Users',
              clearable: true,
              value: choicesValue,
              onChanged: setChoicesValue,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (state, i) {
                final choice = snapshot.data?.elementAt(i);
                return CheckboxListTile(
                  value: state.selected(choice!),
                  onChanged: state.onSelected(choice),
                  title: Text(choice.title),
                  subtitle: choice.subtitle != null
                      ? Text(
                          choice.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  secondary: choice.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(choice.image!),
                        )
                      : null,
                );
              },
              modalHeaderBuilder: ChoiceModalHeader.createBuilder(
                title: const Text('Select Users'),
                actionsBuilder: [
                  (state) {
                    final values = snapshot.data!;
                    return Checkbox(
                      value: state.selectedMany(values),
                      onChanged: state.onSelectedMany(values),
                      tristate: true,
                    );
                  },
                  ChoiceModal.createBuilder(
                    child: const SizedBox(width: 25),
                  ),
                ],
              ),
              promptDelegate: ChoicePrompt.delegateBottomSheet(),
              triggerBuilder: ChoiceTrigger.createBuilder(
                loading: snapshot.connectionState == ConnectionState.waiting,
                valueTruncate: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}
