part of 'error.dart';

abstract class Failure {
  const Failure({this.title, this.message, this.codeError});

  ///Abstract class to define a failure, if the
  ///subclasses have some properties, they`ll get passed to this
  ///constructor so that Equatable can perform value comparison
  final String? title;
  final int? codeError;
  final String? message;

  ///Old Methot
  // const Failure([this.properties = const <dynamic>[]]);
  // final List<dynamic> properties;
  // @override
  // List<Object?> get props => properties;
}

///When the response status is different than 200
class ServerFailure extends Failure {
  ///When the response status is different than 200
  const ServerFailure(this.statusCode) : super();

  final int statusCode;
}

class NetworkFailure extends Failure {
  ///When the app can't connect to the server
  const NetworkFailure();
}

class TimeOutFailure extends Failure {
  ///When the server is slow to respond
  const TimeOutFailure();
}

class AnotherFailure extends Failure {
  ///When an unknown exception occurs
  const AnotherFailure({super.message = '', super.codeError = 0});
}

class DataNull extends Failure {
  ///When the data is it Null
  const DataNull();
}

class AuthFailure extends Failure {
  ///When an unknown exception occurs
  const AuthFailure();
}

class BadRequest extends Failure {
  const BadRequest({super.title, super.message, super.codeError});
}
