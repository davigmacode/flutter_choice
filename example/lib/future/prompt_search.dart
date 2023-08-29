import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

class FuturePromptSearch extends StatefulWidget {
  const FuturePromptSearch({super.key});

  @override
  State<FuturePromptSearch> createState() => _FuturePromptSearchState();
}

class _FuturePromptSearchState extends State<FuturePromptSearch> {
  List<ChoiceData<int>> choicesValue = [];
  late Future<List<ChoiceData<int>>> choicesItem;
  final choicesMemoizer = AsyncMemoizer<List<ChoiceData<int>>>();

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
        subtitle: (i, e) => e['aired']['string'],
        image: (i, e) => e['images']['jpg']['small_image_url'],
      ));
    } on DioException catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  void initState() {
    choicesItem = getChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChoiceData<int>>>(
      initialData: const [],
      future: choicesItem,
      builder: (context, snapshot) {
        return SizedBox(
          width: 300,
          child: Card(
            child: PromptedChoice<ChoiceData<int>>.multiple(
              title: 'Favorite Anime',
              clearable: true,
              searchable: true,
              loading: snapshot.connectionState == ConnectionState.waiting,
              value: choicesValue,
              onChanged: setChoicesValue,
              onSearch: (q) => setChoicesItem(q),
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
              error: snapshot.hasError,
              errorBuilder: ChoiceListError.create(
                message: snapshot.error.toString(),
              ),
              modalHeaderBuilder: ChoiceModalHeader.create(),
              promptDelegate: ChoicePrompt.delegateNewPage(),
              anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
            ),
          ),
        );
      },
    );
  }
}
