import 'package:flutter/material.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/core/utils/notifications.dart';

class ShowFailure {
  ShowFailure._();
  static final ShowFailure instance = ShowFailure._();

  void mapFailuresToNotification(
    BuildContext context, {
    required Failure failure,
    bool validSession = true,
  }) {
    switch (failure.runtimeType) {
      case const (NetworkFailure):
        AppNotification.showNotification(
          context,
          title: 'Revisa tu conexión a internet',
        );
        break;
      case const (TimeOutFailure):
        AppNotification.showNotification(
          context,
          title: 'No pudimos comunicarnos con el servidor',
        );
        break;
      case const (AuthFailure):
        AppNotification.showNotification(
          context,
          title: 'Datos incorrectos o su token expiro',
        );
        if (validSession) {
          // context.read<RouterManager>().go(LoginView.path);
        }
        break;
      case const (AnotherFailure):
      default:
        AppNotification.showNotification(context, title: 'A ocurrido un error');
    }
  }
}
