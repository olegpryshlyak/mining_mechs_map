extension ListX<E> on List<E> {
  List<E> copyListAndChangeElement(
    final bool Function(E element) searchCondition,
    final E Function(E element) changeElement,
  ) {
    final index = indexWhere((final element) => searchCondition(element));
    if (index == -1) {
      return this;
    }
    final list = List<E>.of(this);
    list[index] = changeElement(list[index]);
    return list;
  }

  List<E> copyListAndChangeElementAt(
    final int index,
    final E Function(E element) changeElement,
  ) {
    final list = List<E>.of(this);
    if (list.asMap().containsKey(index)) {
      list[index] = changeElement(list[index]);
      return list;
    } else {
      return this;
    }
  }

  List<E> copyListAndChangeAllElements(
    final bool Function(E element) searchCondition,
    final E Function(E element) changeElement,
  ) {
    final index = indexWhere((final element) => searchCondition(element));
    if (index == -1) {
      return this;
    }
    final list = <E>[];
    for (final value in this) {
      if (searchCondition(value)) {
        list.add(changeElement(value));
      } else {
        list.add(value);
      }
    }
    return list;
  }

  List<E> copyListAndRemoveElement(final bool Function(E element) searchCondition) {
    final index = indexWhere((final element) => searchCondition(element));
    if (index == -1) {
      return this;
    }
    final list = List<E>.of(this);
    list.removeAt(index);
    return list;
  }

  List<E> copyListAndRemoveAllElements(final bool Function(E element) searchCondition) {
    final index = indexWhere((final element) => searchCondition(element));
    if (index == -1) {
      return this;
    }
    final list = <E>[];
    for (final value in this) {
      if (!searchCondition(value)) {
        list.add(value);
      }
    }
    return list;
  }

  List<E> copyListAndAddElement(final E element) {
    final list = List<E>.of(this);
    list.add(element);
    return list;
  }

  List<E> copyListAndAddOrReplaceElement(
    final bool Function(E element) searchCondition,
    final E element,
  ) {
    final list = List<E>.of(this);
    final index = indexWhere((final element) => searchCondition(element));
    if (index == -1) {
      list.add(element);
      return list;
    } else {
      list[index] = element;
      return list;
    }
  }

  List<E> copyListAndReplaceElement(
    final bool Function(E element) searchCondition,
    final E element,
  ) {
    final list = List<E>.of(this);
    final index = indexWhere((final element) => searchCondition(element));
    if (index != -1) {
      list[index] = element;
    }
    return list;
  }

  List<E> copyListAndReorderItem(final int oldIndex, final int newIndex) {
    final list = List.of(this);
    var _newIndex = newIndex;
    if (oldIndex < _newIndex) {
      _newIndex -= 1;
    }
    final item = list.removeAt(oldIndex);
    list.insert(_newIndex, item);
    return list;
  }

  int indexWhereOrDefault(final bool Function(E element) test, final int defaultIndex, [int start = 0]) {
    if (isEmpty) return defaultIndex;
    if (start < 0) start = 0;
    for (var i = start; i < length; i++) {
      if (test(this[i])) return i;
    }
    return defaultIndex;
  }

  E firstWhereOrDefault(final bool Function(E element) test, final E defaultValue) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return defaultValue;
  }

  List<E> sublistOrAll(final int start, [final int end = -1]) =>
      end < 0 || end > length ? this : sublist(start, end - 1);

  List<List<E>> chunks([final int chunkSize = 2]) {
    final pairs = <List<E>>[];
    final len = length;
    for (var i = 0; i < len; i += chunkSize) {
      final size = i + chunkSize;
      pairs.add(sublist(i, size > len ? len : size));
    }
    return pairs;
  }

  List<E> copyListAndRemoveOtherList(final List<E> other) {
    final list = List<E>.of(this);
    for (final element in other) {
      if (list.contains(element)) {
        list.remove(element);
      }
    }
    return list;
  }

  bool hasCommonElements(final List<E> other) {
    final intersection = List.of(this);
    intersection.removeWhere((final e) => !other.contains(e));
    return intersection.isNotEmpty;
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([final Id Function(E element)? id, final bool useSameList = false]) {
    final ids = <dynamic>{};
    final list = useSameList ? this : List<E>.from(this);
    list.retainWhere((final x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension NullableListX on List? {
  bool get nullOrEmpty => this == null || this!.isEmpty;

  bool get notNullAndNotEmpty => this != null && this!.isNotEmpty;
}
