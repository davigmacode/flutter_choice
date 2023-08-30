import 'package:flutter/widgets.dart';
import 'controller/main.dart';
import 'types.dart';

class ChoiceProvider<T> extends InheritedNotifier<ChoiceController<T>> {
  const ChoiceProvider({
    super.key,
    required ChoiceController<T> controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  ChoiceProvider.builder({
    super.key,
    required ChoiceController<T> controller,
    required ChoiceBuilder<T> builder,
    Widget? child,
  }) : super(
          notifier: controller,
          child: Builder(
            builder: (context) {
              return builder(ChoiceProvider.of<T>(context), child);
            },
          ),
        );

  static ChoiceController<T> of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ChoiceProvider<T>>();
    assert(provider != null, 'No ChoiceProvider found in context');
    return provider!.notifier!;
  }

  static ChoiceController<T>? maybeOf<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ChoiceProvider<T>>();
    return provider?.notifier;
  }
}

class ChoiceConsumer<T> extends StatelessWidget {
  const ChoiceConsumer({
    super.key,
    required this.builder,
    this.child,
  });

  /// Builder that gets called when the controller changes
  final ChoiceBuilder<T> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return builder(ChoiceProvider.of<T>(context), child);
  }
}
