import 'package:collection/collection.dart';

String enumToString(final Object o) => o.toString().split('.').last;

T enumFromString<T>(final String key, final List<T> values) =>
    values.firstWhere((final v) => key.toLowerCase() == enumToString(v!).toLowerCase());

T? enumFromStringNullable<T>(final String key, final List<T> values) =>
    values.firstWhereOrNull((final v) => key.toLowerCase() == enumToString(v!).toLowerCase());

T enumFromStringOrDefault<T>(final String key, final List<T> values, final T defaultValue) =>
    values.firstWhereOrNull((final v) => key.toLowerCase() == enumToString(v!).toLowerCase()) ?? defaultValue;
