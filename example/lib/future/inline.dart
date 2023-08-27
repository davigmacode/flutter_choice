import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

class FutureInline extends StatefulWidget {
  const FutureInline({super.key});

  @override
  State<FutureInline> createState() => _FutureInlineState();
}

class _FutureInlineState extends State<FutureInline> {
  List<String> choicesValue = [];
  final choicesMemoizer = AsyncMemoizer<List<dynamic>>();

  void setChoicesValue(List<String> value) {
    setState(() => choicesValue = value);
  }

  Future<List<dynamic>> getChoices() async {
    try {
      const url = "https://randomuser.me/api/?inc=name,picture,email&results=5";
      final res = await Dio().get(url);
      final data = res.data['results'];
      return Future.value(data);
    } on DioException catch (e) {
      throw ErrorDescription(e.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      initialData: const [],
      future: choicesMemoizer.runOnce(getChoices),
      builder: (context, snapshot) {
        final choices = snapshot.data ?? [];
        return InlineChoice<String>(
          clearable: true,
          loading: snapshot.connectionState == ConnectionState.waiting,
          value: choicesValue,
          onChanged: setChoicesValue,
          itemCount: choices.length,
          itemBuilder: (selection, i) {
            final choice = choices.elementAt(i);
            final value = choice['email'];
            final label =
                choice['name']['first'] + ' ' + choice['name']['last'];
            final avatar = choice['picture']['thumbnail'];
            return ChoiceChip(
              selected: selection.selected(value),
              onSelected: selection.onSelected(value),
              checkmarkColor: Colors.white,
              avatar: CircleAvatar(
                backgroundImage: NetworkImage(avatar),
              ),
              label: Text(label),
            );
          },
          listBuilder: ChoiceList.createScrollable(
            spacing: 10,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
          ),
        );
      },
    );
  }
}
