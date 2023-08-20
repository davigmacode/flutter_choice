import 'package:flutter/widgets.dart';
import 'package:choice/utils.dart';
import 'types.dart';

class ChoiceModalController<T> extends ChangeNotifier {
  ChoiceModalController(
    BuildContext context, {
    this.title,
    this.filterable = false,
    required this.closeModal,
  }) {
    this.filter = ChoiceFilterController(context)
      ..addListener(() {
        notifyListeners();
      });
  }

  final String? title;
  final bool filterable;
  final ChoiceModalClose closeModal;

  /// Filter controller
  late final ChoiceFilterController filter;

  @override
  void dispose() {
    filter.dispose();
    super.dispose();
  }
}

class ChoiceFilterController extends ChangeNotifier {
  ChoiceFilterController(this.context);

  final BuildContext context;

  /// Debounce used in search text on changed
  final Debounce debounce = Debounce();

  /// Text controller
  final TextEditingController ctrl = TextEditingController();

  bool _displayed = false;

  String _value = '';

  /// Returns `true` if the filter is displayed
  bool get displayed => _displayed;

  /// Returns the current filter value
  String get value => _value;

  /// Show the filter and add history to route
  void show() {
    // add history to route, so back button will appear
    // and when physical back button pressed
    // will close the search bar instead of close the modal
    LocalHistoryEntry entry = LocalHistoryEntry(onRemove: stop);
    ModalRoute.of(context)?.addLocalHistoryEntry(entry);

    _displayed = true;
    notifyListeners();
  }

  /// Hide the filter and remove history from route
  void hide() {
    // close the filter
    stop();
    // remove filter from route history
    Navigator.pop(context);
  }

  /// Clear and close filter
  void stop() {
    _displayed = false;
    clear();
  }

  /// Just clear the filter text
  void clear() {
    ctrl.clear();
    apply('');
  }

  /// Apply new value to filter query
  void apply(String val) {
    _value = val;
    notifyListeners();
  }

  /// Apply new value to filter query
  void applyDelayed(String val, [Duration? delay]) {
    debounce.run(
      () => apply(val),
      delay: delay,
    );
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }
}
