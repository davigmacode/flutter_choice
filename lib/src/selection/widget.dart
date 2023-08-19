import 'package:flutter/widgets.dart';
import 'controller.dart';
import 'provider.dart';

class Choice<T> extends StatelessWidget {
  const Choice({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required this.child,
  });

  final String? title;
  final bool multiple;
  final bool mandatory;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final Widget child;

  static ChoiceController<T> of<T>(BuildContext context) {
    return ChoiceProvider.of<T>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceProvider<T>(
      controller: ChoiceController<T>(
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
