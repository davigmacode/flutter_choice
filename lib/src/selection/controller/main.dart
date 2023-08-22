import 'package:flutter/widgets.dart';
import 'filter.dart';

class ChoiceController<T> extends ChangeNotifier {
  ChoiceController({
    List<T> value = const [],
    ValueChanged<List<T>>? onChanged,
    ValueChanged<List<T>?>? onCloseModal,
    ChoiceFilterController? filter,
    this.multiple = false,
    this.mandatory = false,
    this.confirmation = false,
    this.title,
  })  : _onCloseModal = onCloseModal,
        _onChanged = onChanged,
        _value = Set.from(value) {
    this.filter = filter
      ?..addListener(() {
        notifyListeners();
      });
  }

  ChoiceController<T> copyWith({
    List<T>? value,
    ValueChanged<List<T>>? onChanged,
    ValueChanged<List<T>?>? onCloseModal,
    ChoiceFilterController? filter,
    bool? multiple,
    bool? mandatory,
    bool? confirmation,
    String? title,
  }) {
    return ChoiceController<T>(
      value: value ?? this.value,
      onChanged: onChanged ?? this._onChanged,
      onCloseModal: onCloseModal ?? this._onCloseModal,
      multiple: multiple ?? this.multiple,
      mandatory: mandatory ?? this.mandatory,
      confirmation: confirmation ?? this.confirmation,
      filter: filter ?? this.filter,
      title: title ?? this.title,
    );
  }

  final Set<T> _value;

  final ValueChanged<List<T>>? _onChanged;

  late final ValueChanged<List<T>?>? _onCloseModal;

  final String? title;

  /// allow to select multiple values
  final bool multiple;

  /// will always have a value
  final bool mandatory;

  final bool confirmation;

  /// Filter controller
  late final ChoiceFilterController? filter;

  bool get filterable => filter != null;

  List<T> get value => _value.toList();

  T? get single => _value.elementAtOrNull(0);

  int get length => _value.length;

  bool get isEmpty => _value.isEmpty;

  bool get isNotEmpty => _value.isNotEmpty;

  bool selected(T choice) => _value.contains(choice);

  bool any(List<T> choices) => choices.any((e) => _value.contains(e));

  bool every(List<T> choices) => choices.every((e) => _value.contains(e));

  bool? selectedMany(List<T> choices) => every(choices)
      ? true
      : any(choices)
          ? null
          : false;

  ValueChanged<bool?> onSelectedMany(
    List<T> choices, {
    ValueChanged<List<T>>? onChanged,
  }) {
    return (bool? active) {
      selectMany(choices, active);
      onChanged?.call(value);
    };
  }

  ValueChanged<bool?> onSelected(
    T choice, {
    ValueChanged<List<T>>? onChanged,
  }) {
    return (bool? active) {
      if (selected(choice) == active) return;
      select(choice, active);
      onChanged?.call(value);
    };
  }

  /// Mutator to mark a [List<T>] value as either active or inactive.
  void selectMany(List<T> choices, [bool? active]) {
    active ??= false;
    if (active) {
      replace(choices);
    } else {
      clear();
    }
  }

  /// Mutator to mark a [T] value as either active or inactive.
  void select(T choice, [bool? active]) {
    active = active ?? !selected(choice);
    if (active) {
      if (multiple) {
        add(choice);
      } else {
        replace([choice]);
      }
    } else {
      remove(choice);
    }
    if (!confirmation && !multiple) {
      closeModal(confirmed: true);
    }
  }

  /// Mutator to mark a [T] value as active.
  void add(T choice) {
    if (_value.add(choice)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  /// Mutator to mark a [T] value as inactive.
  void remove(T choice) {
    if (mandatory && _value.length == 1) return;

    if (_value.remove(choice)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  void replace(List<T> choices) {
    _value
      ..clear()
      ..addAll(choices);
    notifyListeners();
    _onChanged?.call(value);
  }

  void clear() {
    _value.clear();
    notifyListeners();
    _onChanged?.call(value);
  }

  void closeModal({confirmed = true, VoidCallback? onClosed}) {
    filter?.hide();
    _onCloseModal?.call(confirmed == true ? value : null);
    onClosed?.call();
  }
}
