part of 'extension.dart';

typedef OnResponValue<T> = dynamic Function(Map<String, dynamic> bod);

extension HttpResponseConverter on Response {
  T withConverter<T>({
    required OnResponValue<T> callback,
  }) {
    dynamic body = jsonDecode(utf8.decode(bodyBytes));

    return callback((body ?? <String, dynamic>{}) as Map<String, dynamic>) as T;
  }

  List<T> withListConverter<T>({required OnResponValue<T> callback}) =>
      (jsonDecode(utf8.decode(bodyBytes)) as List<dynamic>)
          .map(
            (dynamic e) =>
                callback((e ?? <String, dynamic>{}) as Map<String, dynamic>)
                    as T,
          )
          .toList();

  T withConverterFromKey<T>(
    String key, {
    required OnResponValue<T> callback,
  }) {
    dynamic body = jsonDecode(utf8.decode(bodyBytes));
    return callback((body[key] ?? <String, dynamic>{}) as Map<String, dynamic>)
        as T;
  }

  List<T> withListConverterFromKey<T>(
    String key, {
    required OnResponValue<T> callback,
  }) =>
      (jsonDecode(utf8.decode(bodyBytes))[key] as List<dynamic>)
          .map(
            (dynamic e) =>
                callback((e ?? <String, dynamic>{}) as Map<String, dynamic>)
                    as T,
          )
          .toList();
}
