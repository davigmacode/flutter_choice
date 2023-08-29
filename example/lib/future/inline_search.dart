import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

class FutureInlineSearch extends StatefulWidget {
  const FutureInlineSearch({super.key});

  @override
  State<FutureInlineSearch> createState() => _FutureInlineSearchState();
}

class _FutureInlineSearchState extends State<FutureInlineSearch> {
  List<ChoiceData<int>> choicesValue = [];
  late Future<List<ChoiceData<int>>> choicesItem;
  final choicesMemoizer = AsyncMemoizer<List<ChoiceData<int>>>();
  final searchCtrl = TextEditingController();

  void setChoicesItem(String? q) {
    setState(() {
      choicesItem = getChoices(q);
    });
  }

  void setChoicesValue(List<ChoiceData<int>> value) {
    setState(() => choicesValue = value);
  }

  Future<List<ChoiceData<int>>> getChoices([String? q]) async {
    try {
      const url = "https://api.jikan.moe/v4/anime";
      final res = await Dio().get(url, queryParameters: {'q': q});
      final data = res.data['data'] as List;
      return Future.value(data.asChoiceData(
        value: (i, e) => e['mal_id'],
        title: (i, e) => e['titles'][0]['title'],
        image: (i, e) => e['images']['jpg']['small_image_url'],
      ));
    } on DioException catch (e) {
      throw ErrorDescription(e.message ?? '');
    }
  }

  @override
  void initState() {
    choicesItem = getChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black12,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchCtrl,
                  onSubmitted: (value) {
                    setChoicesItem(value);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search and select your favorite anime',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setChoicesItem(searchCtrl.text);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: ChoiceValueText(
            value: choicesValue,
            truncate: 5,
          ),
        ),
        FutureBuilder<List<ChoiceData<int>>>(
          initialData: const [],
          future: choicesItem,
          builder: (context, snapshot) {
            final choices = snapshot.data ?? [];
            return InlineChoice<ChoiceData<int>>(
              clearable: true,
              multiple: true,
              loading: snapshot.connectionState == ConnectionState.waiting,
              value: choicesValue,
              onChanged: setChoicesValue,
              itemCount: choices.length,
              itemBuilder: (state, i) {
                final choice = choices.elementAt(i);
                return ChoiceChip(
                  selected: state.selected(choice),
                  onSelected: state.onSelected(choice),
                  label: Text(choice.title),
                );
              },
              listBuilder: ChoiceList.createWrapped(
                spacing: 10,
                runSpacing: 10,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}