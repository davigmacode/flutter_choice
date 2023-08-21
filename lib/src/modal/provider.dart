import 'package:flutter/widgets.dart';
import 'controller.dart';
import 'types.dart';

class ChoiceModalProvider<T>
    extends InheritedNotifier<ChoiceModalController<T>> {
  const ChoiceModalProvider({
    super.key,
    required ChoiceModalController<T> controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  ChoiceModalProvider.builder({
    super.key,
    required ChoiceModalController<T> controller,
    required ChoiceModalProviderBuilder<T> builder,
    Widget? child,
  }) : super(
          notifier: controller,
          child: Builder(
            builder: (context) {
              return builder(ChoiceModalProvider.of<T>(context), child);
            },
          ),
        );

  static ChoiceModalController<T> of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ChoiceModalProvider<T>>();
    assert(provider != null, 'No ChoiceModalProvider found in context');
    return provider!.notifier!;
  }
}

class ChoiceModalConsumer<T> extends StatelessWidget {
  const ChoiceModalConsumer({
    super.key,
    required this.builder,
    this.child,
  });

  /// Builder that gets called when the controller changes
  final ChoiceModalProviderBuilder<T> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return builder(ChoiceModalProvider.of<T>(context), child);
  }
}
