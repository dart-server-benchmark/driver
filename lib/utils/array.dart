class Array {
  static int add<E>(List<E> iterable, int getter(E e)) =>
      iterable.map(getter).fold(0, (int sum, int newV) => sum + newV);

  static Duration addDuration<E>(List<E> iterable, Duration getter(E e)) =>
      iterable
          .map(getter)
          .fold(new Duration(), (Duration sum, Duration newV) => sum + newV);

  static T max<E, T extends Comparable>(List<E> iterable, T getter(E e)) =>
      iterable.map(getter).fold(null, (T oldMax, T newV) {
        if (oldMax == null) return newV;
        return oldMax.compareTo(newV) >= 0 ? oldMax : newV;
      });

  static int count<E>(List<E> iterable, bool getter(E e)) =>
      iterable.where(getter).length;
}

class Iterex<E> {
  final Iterable<E> iterable;

  Iterex(this.iterable);

  int add(int getter(E e)) => Array.add<E>(iterable, getter);

  Duration addDuration(Duration getter(E e)) =>
      Array.addDuration<E>(iterable, getter);

  T max<T extends Comparable>(T getter(E e)) =>
      Array.max<E, T>(iterable, getter);

  int count(bool getter(E e)) => iterable.where(getter).length;
}
