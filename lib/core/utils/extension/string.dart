part of 'extension.dart';

extension NotNullStringExtension on String {
  num get currencyToNum {
    String unmasked =
        replaceFirst('\$', '').replaceAll(',', '').trim().replaceAll(' ', '');
    return num.tryParse(unmasked) ?? 0;
  }

  num genericCurrencyToNum({String thousandSeparator = ','}) {
    String unmasked = replaceFirst('\$', '')
        .replaceAll(thousandSeparator, '')
        .trim()
        .replaceAll(' ', '');
    return num.tryParse(unmasked) ?? 0;
  }

  String get withoutSymbol => replaceFirst('\$ ', '');

  String get commaToDot => replaceFirst('\$ ', '').replaceAll(',', '.');

  String get clean => trim().replaceAll(' ', '');

  String get maskPhoneNumber => replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d+)'),
        (Match m) => '${m[1]}-${m[2]}-${m[3]}',
      );

  String get maskPhoneNumberWithSpaces => replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d+)'),
        (Match m) => '${m[1]} ${m[2]} ${m[3]}',
      );

  String get formatWithMax9Digits {
    num parsed = num.tryParse(this) ?? 0;
    if (parsed == 0) {
      return '0';
    }
    NumberFormat formatter = NumberFormat()
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = 9;
    return formatter.format(parsed);
  }

  String get formatCOPCurrency => replaceAll(',', '.').replaceRange(
        length - 3,
        length - 2,
        ',',
      );

  String get removeQueryParams {
    List<String> result = split('?');
    return result.length > 1 ? result.first : this;
  }
}

extension NullableStringExtension on String? {
  String? toParamUrl(Map<String, dynamic> params) {
    if (this != null) {
      return params.replaceUrlParams(this!);
    }
    return null;
  }

  bool get toBool => this == 'true';

  bool get toIntBool {
    num? entero = num.tryParse(this!);
    if (entero == 1) {
      return true;
    }
    return false;
  }

  num? get toNumeric => num.tryParse(this!);

  double? get toDouble => num.tryParse(this!)?.toDouble();

  int? get toInt => num.tryParse(this!)?.toInt();

  DateTime? get toDateTime {
    if (this == null) {
      return null;
    }
    return DateTime.tryParse(this!)!;
  }
}
