import 'package:flutter/widgets.dart';
import 'search.dart';

/// {@template choice.selection}
/// Controller of the selection value and how it behaves
/// {@endtemplate}
class ChoiceController<T> extends ChangeNotifier {
  /// Create a controller of the selection value and how it behaves
  ///
  /// {@template choice.params.universal}
  /// The [value] prop is the initial selection value
  ///
  /// The [onChanged] prop called when the choice selection should change
  ///
  /// The [clearable] prop determines whether the choice can be cleared
  /// {@endtemplate}
  ///
  /// {@template choice.params.multiple}
  /// The [multiple] prop determines whether the choice is multiple or single selection
  /// {@endtemplate}
  ///
  /// {@template choice.params.prompt}
  /// The [confirmation] prop specifies whether the choice selection needs to be confirmed
  ///
  /// The [searchable] prop specifies whether the choice can be searched
  ///
  /// The [title] prop is primary text of the modal and trigger widget
  /// {@endtemplate}
  ///
  /// The [search] is
  /// {@macro choice.search}
  ///
  /// The [onCloseModal] is called to close modal
  ChoiceController({
    List<T> value = const [],
    ValueChanged<List<T>>? onChanged,
    ValueChanged<List<T>?>? onCloseModal,
    ChoiceSearchController? search,
    this.multiple = false,
    this.clearable = false,
    this.confirmation = false,
    this.loading = false,
    this.error = false,
    this.title,
  })  : _onCloseModal = onCloseModal,
        _onChanged = onChanged,
        _value = Set.from(value) {
    this.search = search
      ?..addListener(() {
        notifyListeners();
      });
  }

  static ChoiceController<T> createModalController<T>({
    required BuildContext modalContext,
    required ChoiceController<T> rootController,
    bool searchable = false,
    ValueChanged<String>? onSearch,
  }) {
    return rootController.copyWith(
      search: ChoiceSearchController.create(
        context: modalContext,
        searchable: searchable,
        onChanged: onSearch,
      ),
      onCloseModal: (value) {
        Navigator.maybePop(modalContext, value);
      },
      onChanged: (value) {
        if (!rootController.confirmation) {
          rootController.replace(value);
        }
      },
    );
  }

  /// Creates a copy of this [ChoiceController] but with
  /// the given fields replaced with the new values
  ChoiceController<T> copyWith({
    List<T>? value,
    ValueChanged<List<T>>? onChanged,
    ValueChanged<List<T>?>? onCloseModal,
    ChoiceSearchController? search,
    bool? multiple,
    bool? clearable,
    bool? confirmation,
    bool? loading,
    bool? error,
    String? title,
  }) {
    return ChoiceController<T>(
      value: value ?? this.value,
      onChanged: onChanged ?? this._onChanged,
      onCloseModal: onCloseModal ?? this._onCloseModal,
      multiple: multiple ?? this.multiple,
      clearable: clearable ?? this.clearable,
      confirmation: confirmation ?? this.confirmation,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      search: search ?? this.search,
      title: title ?? this.title,
    );
  }

  /// Creates a copy of this [ChoiceController] but with
  /// the given fields replaced with the new values.
  ChoiceController<T> merge(ChoiceController<T>? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      value: other.value,
      multiple: other.multiple,
      clearable: other.clearable,
      confirmation: other.confirmation,
      loading: other.loading,
      error: other.error,
      search: other.search,
      title: other.title,
    );
  }

  /// {@template choice.value}
  /// List of type `T` of the selection value
  /// {@endtemplate}
  final Set<T> _value;

  /// {@template choice.onChanged}
  /// Called when the choice selection should change.
  ///
  /// The controller passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the controller with the new value.
  ///
  /// The callback provided to [onChanged] should update the state of the
  /// parent [StatefulWidget] using the [State.setState] method, so that the
  /// parent gets rebuilt.
  ///
  /// A [StatefulWidget] that illustrates use of onChanged in an [InlineChoice].
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class InlineWrapped extends StatefulWidget {
  ///   const InlineWrapped({super.key});
  ///
  ///   @override
  ///   State<InlineWrapped> createState() => _InlineWrappedState();
  /// }
  ///
  /// class _InlineWrappedState extends State<InlineWrapped> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///   ];
  ///
  ///   List<String> selectedValue = [];
  ///
  ///   void setSelectedValue(List<String> value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return InlineChoice<String>(
  ///       multiple: true,
  ///       clearable: true,
  ///       value: selectedValue,
  ///       onChanged: setSelectedValue,
  ///       itemCount: choices.length,
  ///       itemBuilder: (state, i) {
  ///         return ChoiceChip(
  ///           selected: state.selected(choices[i]),
  ///           onSelected: state.onSelected(choices[i]),
  ///           label: Text(choices[i]),
  ///         );
  ///       },
  ///       listBuilder: ChoiceList.createWrapped(
  ///         spacing: 10,
  ///         runSpacing: 10,
  ///         padding: const EdgeInsets.symmetric(
  ///           horizontal: 20,
  ///           vertical: 25,
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  /// {@endtemplate}
  final ValueChanged<List<T>>? _onChanged;

  /// {@template choice.onCloseModal}
  /// Called to close modal
  /// {@endtemplate}
  late final ValueChanged<List<T>?>? _onCloseModal;

  /// {@template choice.title}
  /// Primary text of the modal and trigger widget
  /// {@endtemplate}
  final String? title;

  /// {@template choice.multiple}
  /// Determines whether the choice is multiple or single selection
  /// {@endtemplate}
  final bool multiple;

  /// {@template choice.clearable}
  /// Determines whether the choice can be cleared
  /// {@endtemplate}
  final bool clearable;

  /// {@template choice.confirmation}
  /// Specifies whether the choice selection needs to be confirmed
  /// {@endtemplate}
  final bool confirmation;

  /// {@template choice.loading}
  /// Specify whether the choice items is in loading state
  /// {@endtemplate}
  final bool loading;

  /// {@template choice.error}
  /// Specifies whether the choice list has error
  /// {@endtemplate}
  final bool error;

  /// {@macro choice.search}
  late final ChoiceSearchController? search;

  /// {@template choice.searchable}
  /// Specifies whether the choice can be searched
  /// {@endtemplate}
  bool get searchable => search != null;

  /// Returns a list of type `T` of the selection value
  List<T> get value => _value.toList();

  /// Returns the first element of [value], or null
  T? get single => _value.elementAtOrNull(0);

  /// Returns the number of elements in the [value]
  int get length => _value.length;

  /// Whether the [value] has no elements
  bool get isEmpty => _value.isEmpty;

  /// Whether the [value] has at least one element
  bool get isNotEmpty => _value.isNotEmpty;

  /// Whether the [value] has at least one element of the [choices] collection
  bool any(List<T> choices) => choices.any((e) => _value.contains(e));

  /// Whether the [value] has every element of the [choices] collection
  bool every(List<T> choices) => choices.every((e) => _value.contains(e));

  /// Returns an indeterminate whether the [value] has every element of the [choices] collection
  bool? selectedMany(List<T> choices) => every(choices)
      ? true
      : any(choices)
          ? null
          : false;

  /// Whether the [value] has [choice] value or not
  bool selected(T choice) => _value.contains(choice);

  /// Create a callback to toggle select each element of [choices] collection
  ValueChanged<bool?> onSelectedMany(
    List<T> choices, {
    ValueChanged<List<T>>? onChanged,
  }) {
    return (bool? active) {
      selectMany(choices, active);
      onChanged?.call(value);
    };
  }

  /// Create a callback to toggle select [choice] value
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

  /// Toggle select each element of [choices] collection
  void selectMany(List<T> choices, [bool? active]) {
    active ??= !any(choices);
    if (active) {
      addMany(choices);
    } else {
      removeMany(choices);
    }
  }

  /// Toggle select [choice] value
  void select(T choice, [bool? active]) {
    active ??= !selected(choice);
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

  /// Add [choice] to [value] collection
  void add(T choice) {
    if (_value.add(choice)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  void addMany(List<T> choices) {
    if (!every(choices)) {
      _value.addAll(choices);
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  /// Removes [choice] from [value] collection
  void remove(T choice) {
    if (!clearable && _value.length == 1) return;

    if (_value.remove(choice)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  /// Removes each element of [choices] from [value] collection
  void removeMany(List<T> choices) {
    if (!clearable && every(choices)) return;

    _value.removeAll(choices);
    notifyListeners();
    _onChanged?.call(value);
  }

  /// Replace [value] with each element of [choices] collection
  void replace(List<T> choices) {
    _value
      ..clear()
      ..addAll(choices);
    notifyListeners();
    _onChanged?.call(value);
  }

  /// Removes each element of [value] collection
  void clear() {
    if (clearable) {
      _value.clear();
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  void closeModal({confirmed = true, VoidCallback? onClosed}) {
    search?.detach();
    _onCloseModal?.call(confirmed == true ? value : null);
    onClosed?.call();
  }
}
