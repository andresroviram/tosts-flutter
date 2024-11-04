part of 'extension.dart';

extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> get filterOutNulls {
    Map<String, dynamic> filtered = <String, dynamic>{};
    forEach((String key, dynamic value) {
      if (value != null) {
        filtered[key] = value;
      }
    });
    return filtered;
  }

  Map<String, dynamic> difference(Map<String, dynamic> newValue) {
    Map<String, dynamic> filtered = <String, dynamic>{};
    newValue.forEach((String key, dynamic value) {
      if (!containsKey(key) || newValue[key] != this[key]) {
        filtered[key] = value;
      }
    });
    return filtered;
  }

  String? getString(String key) => this[key]?.toString();

  DateTime? getDateTime(String key) => getString(key)?.toDateTime;

  num? getNum(String key) => getString(key)?.toNumeric;

  double? getDouble(String key) => getString(key)?.toDouble;

  int? getInt(String key) => getString(key)?.toInt;

  bool? getBool(String key) => getString(key)?.toBool;

  bool? getIntToBool(String key) => getString(key)?.toIntBool;

  List<dynamic>? getList(String key) =>
      (this[key] ?? <dynamic>[]) as List<dynamic>;

  Map<String, dynamic>? getMap(String key) =>
      this[key] as Map<String, dynamic>?;

  String replaceUrlParams(String url) {
    String newUrl = url;
    forEach((String key, dynamic value) {
      newUrl = newUrl.replaceFirst(':$key', value.toString());
    });
    return newUrl;
  }

  String get queryParams {
    String params = entries
        .map(
          (MapEntry<String, dynamic> entry) => '${entry.key}=${entry.value}',
        )
        .join('&');
    return '?$params';
  }
}
