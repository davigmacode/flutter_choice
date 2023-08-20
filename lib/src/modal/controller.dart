import 'package:flutter/widgets.dart';
import 'package:choice/utils.dart';
import 'types.dart';

class ChoiceModalController<T> extends ChangeNotifier {
  ChoiceModalController(
    BuildContext context, {
    this.title,
    this.filterable = false,
    required ChoiceModalClose close,
    required ValueSetter<T> closeAndSelect,
    required ValueSetter<List<T>> closeAndSelectMany,
  }) {
    this._close = close;
    this._closeAndSelect = closeAndSelect;
    this._closeAndSelectMany = closeAndSelectMany;
    this.filter = ChoiceFilterController(context)
      ..addListener(() {
        notifyListeners();
      });
  }

  final String? title;
  final bool filterable;
  late final ChoiceModalClose _close;
  late final ValueSetter<T> _closeAndSelect;
  late final ValueSetter<List<T>> _closeAndSelectMany;

  /// Filter controller
  late final ChoiceFilterController filter;

  void close({confirmed = true, VoidCallback? onClosed}) {
    filter.hide();
    _close(confirmed: confirmed, onClosed: onClosed);
  }

  void closeAndSelect(T choice) {
    filter.hide();
    _closeAndSelect(choice);
  }

  void closeAndSelectMany(List<T> choices) {
    filter.hide();
    _closeAndSelectMany(choices);
  }

  @override
  void dispose() {
    filter.dispose();
    super.dispose();
  }
}

class ChoiceFilterController extends ChangeNotifier {
  ChoiceFilterController(BuildContext context) : _context = context;

  final BuildContext _context;

  /// Debounce used in search text on changed
  final Debounce _debounce = Debounce();

  bool _active = false;

  String _value = '';

  /// Returns `true` if the filter is displayed
  bool get active => _active;

  /// Returns the current filter value
  String get value => _value;

  /// Show the filter and add history to route
  void show() {
    if (!_active) {
      // add history to route, so back button will appear
      // and when physical back button pressed
      // will close the search bar instead of close the modal
      LocalHistoryEntry entry = LocalHistoryEntry(onRemove: _close);
      ModalRoute.of(_context)?.addLocalHistoryEntry(entry);

      _active = true;
      notifyListeners();
    }
  }

  /// Hide the filter and remove history from route
  void hide() {
    if (_active) {
      // close the filter
      _close();
      // remove filter from route history
      Navigator.pop(_context);
    }
  }

  /// Clear and close filter
  void _close() {
    _active = false;
    clear();
  }

  /// Just clear the filter text
  void clear() {
    apply('');
  }

  /// Apply new value to filter query
  void _apply(String val) {
    _value = val;
    notifyListeners();
  }

  /// Apply new value to filter query
  void apply(String val, [Duration? delay]) {
    if (delay != null) {
      _debounce.run(
        () => _apply(val),
        delay: delay,
      );
    } else {
      _apply(val);
    }
  }
}
