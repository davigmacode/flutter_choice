import 'package:flutter/widgets.dart';

class ChoiceValueText<T> extends StatelessWidget {
  const ChoiceValueText({
    super.key,
    required this.value,
    this.placeholder = 'Select one or more',
    this.truncate,
  });

  final List<T> value;
  final String placeholder;
  final int? truncate;

  @override
  Widget build(BuildContext context) {
    final display = truncate ?? value.length;
    final stringify = value.isNotEmpty
        ? value.length > display
            ? display > 0
                ? '${value.take(display).join(', ')}, and ${value.length - display} more'
                : '${value.length} Selected'
            : value.join(', ')
        : placeholder;
    return Text(stringify);
  }
}
