import 'dart:math';

class XL {
  static void _assertNotEmpty<T>(Iterable<T> items, String name) {
    if (items.isEmpty) {
      throw ArgumentError('$name must not be empty.');
    }
  }

  static List<double> _nums(Iterable<num> nums) => nums.map((e) => e.toDouble()).toList();

  static double sum(Iterable<num> values) {
    double s = 0;
    for (final v in values) s += v;
    return s;
  }

  static int count<T>(Iterable<T?> values, {bool countBlank = false}) {
    if (countBlank) return values.length;
    return values.where((e) => e != null && e.toString().trim().isNotEmpty).length;
  }

  static double average(Iterable<num> values) {
    _assertNotEmpty(values, 'average(values)');
    final v = _nums(values);
    return sum(v) / v.length;
  }

  static double minVal(Iterable<num> values) {
    _assertNotEmpty(values, 'min(values)');
    return values.reduce((a, b) => a < b ? a : b).toDouble();
  }

  static double maxVal(Iterable<num> values) {
    _assertNotEmpty(values, 'max(values)');
    return values.reduce((a, b) => a > b ? a : b).toDouble();
  }

  static double roundTo(num value, int places) {
    final factor = pow(10, places).toDouble();
    return (value.toDouble() * factor).round() / factor;
  }

  static double median(Iterable<num> values) {
    _assertNotEmpty(values, 'median(values)');
    final v = _nums(values)..sort();
    final n = v.length;
    return n.isOdd ? v[n ~/ 2] : (v[n ~/ 2 - 1] + v[n ~/ 2]) / 2.0;
  }

  static double varS(Iterable<num> values) {
    _assertNotEmpty(values, 'varS(values)');
    final v = _nums(values);
    if (v.length < 2) return double.nan;
    final m = average(v);
    double s = 0;
    for (final x in v) {
      s += pow(x - m, 2).toDouble();
    }
    return s / (v.length - 1);
  }

  static double stdevS(Iterable<num> values) => sqrt(varS(values));
}
