extension ExtendedIterable<E> on Iterable<E> {
  /// Adds index argument to map function
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  /// Adds index argument to forEach function
  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }

  /// Fold right to an arbitrary type
  T foldRight<T>(
      T Function(T accumulator, E element) accumulate, T initialValue) {
    T accumulatedValue = initialValue;
    for (E value in this) {
      accumulatedValue = accumulate(accumulatedValue, value);
    }

    return accumulatedValue;
  }
}

extension ExtendedList<E> on List<E> {
  /// Makes a copy and inserts element at index
  List<E> copyInsertAt(int index, E element) {
    return [
      ...this.sublist(0, index),
      element,
      ...this.sublist(index),
    ];
  }

  /// Makes a copy that removes the element at index
  List<E> copyRemoveAt(int index) {
    return [
      ...this.sublist(0, index),
      ...this.sublist(index + 1),
    ];
  }

  /// Makes a copy and updates the index given the update function
  List<E> copyUpdateAt(int index, E Function(E element) updateFn) {
    return [
      ...this.sublist(0, index),
      updateFn(this[index]),
      ...this.sublist(index + 1),
    ];
  }

  Map<K, E> asMapUsing<K>(K Function(E element) mapper) {
    return this.foldRight<Map<K, E>>(
      (accumulator, element) => {
        ...accumulator,
        mapper(element): element,
      },
      {},
    );
  }
}
