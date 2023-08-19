import 'package:flutter/widgets.dart';
import 'controller.dart';
import 'provider.dart';
import 'types.dart';

class ChoiceSelection<T> extends StatelessWidget {
  const ChoiceSelection({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required this.child,
  });

  ChoiceSelection.builder({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required ChoiceSelectionBuilder<T> builder,
    Widget? child,
  }) : child = ChoiceSelectionConsumer<T>(
          builder: builder,
          child: child,
        );

  final String? title;
  final bool multiple;
  final bool mandatory;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final Widget child;

  static ChoiceSelectionController<T> of<T>(BuildContext context) {
    return ChoiceSelectionProvider.of<T>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceSelectionProvider<T>(
      controller: ChoiceSelectionController<T>(
        value: value,
        onChanged: onChanged,
        multiple: multiple,
        mandatory: mandatory,
        title: title,
      ),
      child: child,
    );
  }
}
