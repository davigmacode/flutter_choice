import 'package:flutter/material.dart';
import 'package:choice_example/sample.dart';
import 'package:choice_example/layout.dart';
import 'popup_dialog.dart';
import 'bottom_sheet.dart';
import 'new_page.dart';
import 'modal_composition.dart';
import 'confirmation.dart';
import 'filterable.dart';
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
          child: PromptedPopupDialog(),
        ),
        SamplePanel(
          title: 'Bottom Sheet',
          child: PromptedBottomSheet(),
        ),
        SamplePanel(
          title: 'New Page',
          child: PromptedNewPage(),
        ),
        SamplePanel(
          title: 'Modal Header, Footer, and Separator',
          child: PromptedModal(),
        ),
        SamplePanel(
          title: 'Confirmation',
          child: PromptedConfirmation(),
        ),
        SamplePanel(
          title: 'Filterable and Highlighted Result',
          child: PromptedFilterable(),
        ),
        SamplePanel(
          title: 'Trigger Widget',
          child: PromptedTrigger(),
        ),
      ],
    );
  }
}
