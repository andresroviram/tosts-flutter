part of 'error.dart';

class ServerException implements Exception {
  ServerException({
    required this.statusCode,
    this.url,
    this.message,
    this.stackTrace,
  });

  final int statusCode;
  final String? url;
  final String? message;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      '''ServerException: [status: $statusCode url: $url message: $message] : $stackTrace''';
}

///Se lanza cuando ocurre una excepcion con la conexión o peticion http
class BaseClientException implements Exception {
  BaseClientException({
    required this.type,
    required this.url,
    this.statusCode,
    this.message,
    this.stackTrace,
  });
  final String type;
  final String url;
  final int? statusCode;
  final String? message;
  final StackTrace? stackTrace;

  @override
  String toString() => '$type [status: $statusCode url: $url] : $message';
}

///Se lanza si el token no se encontró en el secure storage
class TokenNotFoundException implements Exception {
  @override
  String toString() => 'the token was not found in the secure storage';
}
