import 'package:flutter/material.dart';
import 'package:choice_example/sample.dart';
import 'package:choice_example/layout.dart';
import 'popup_dialog.dart';
import 'bottom_sheet.dart';
import 'new_page.dart';
import 'modal_composition.dart';
import 'confirmation.dart';
import 'searchable.dart';
import 'trigger.dart';

class PromptedChoicePage extends StatefulWidget {
  const PromptedChoicePage({super.key});

  @override
  State<PromptedChoicePage> createState() => _PromptedChoicePageState();
}

class _PromptedChoicePageState extends State<PromptedChoicePage> {
  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Prompted Choice',
      children: <Widget>[
        SamplePanel(
          title: 'Popup Dialog',
          source: 'prompt/popup_dialog.dart',
          child: PromptedPopupDialog(),
        ),
        SamplePanel(
          title: 'Bottom Sheet',
          source: 'prompt/bottom_sheet.dart',
          child: PromptedBottomSheet(),
        ),
        SamplePanel(
          title: 'New Page',
          source: 'prompt/new_page.dart',
          child: PromptedNewPage(),
        ),
        SamplePanel(
          title: 'Modal Header, Footer, and Separator',
          source: 'prompt/modal_composition.dart',
          child: PromptedModal(),
        ),
        SamplePanel(
          title: 'Confirmation',
          source: 'prompt/confirmation.dart',
          child: PromptedConfirmation(),
        ),
        SamplePanel(
          title: 'Searchable and Highlighted Result',
          source: 'prompt/searchable.dart',
          child: PromptedSearchable(),
        ),
        SamplePanel(
          title: 'Trigger Widget',
          source: 'prompt/trigger.dart',
          child: PromptedTrigger(),
        ),
      ],
    );
  }
}
