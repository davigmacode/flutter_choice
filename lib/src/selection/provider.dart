import 'package:flutter/widgets.dart';
import 'controller.dart';
import 'types.dart';

class ChoiceSelectionProvider<T>
    extends InheritedNotifier<ChoiceSelectionController<T>> {
  const ChoiceSelectionProvider({
    super.key,
    required ChoiceSelectionController<T> controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static ChoiceSelectionController<T> of<T>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ChoiceSelectionProvider<T>>();
    assert(provider != null, 'No ChoiceSelectionProvider found in context');
    return provider!.notifier!;
  }
}

class ChoiceSelectionConsumer<T> extends StatelessWidget {
  const ChoiceSelectionConsumer({
    super.key,
    required this.builder,
    this.child,
  });

  /// Builder that gets called when the controller changes
  final ChoiceSelectionBuilder<T> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return builder(ChoiceSelectionProvider.of<T>(context), child);
  }
}
