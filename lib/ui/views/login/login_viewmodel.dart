import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/core/utils/overloading.dart';
import 'package:minimal_app/modules/login/domain/entities/user_entities.dart';
import 'package:minimal_app/modules/login/domain/usecases/login_usecases.dart';
import 'package:minimal_app/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _loginUseCase = locator<LoginUseCase>();
  final _preferences = locator<SharedPreferencesService>();
  final OverlayEntry _loader =
      Overloading.instance.overLayEntry(isAnimationTime: false);
  OverlayEntry get loader => _loader;

  TextEditingController emailController =
      TextEditingController(text: 'user@tots.agency');
  TextEditingController passwordController =
      TextEditingController(text: '123Qwerty');

  NavigationService get navigationService => _navigationService;
  bool _isObscured = true;
  Failure? _failure;
  UserEntity? _user;

  bool get isObscured => _isObscured;
  Failure? get failure => _failure;
  UserEntity? get user => _user;

  void toggleObscured() {
    _isObscured = !_isObscured;
    rebuildUi();
  }

  Future<void> login() async {
    setBusy(true);

    UserEntity user = UserEntity(
      email: emailController.text,
      password: passwordController.text,
    );
    Either<Failure, UserEntity> either = await _loginUseCase.login(user);
    either.fold(
      (Failure failure) {
        setBusy(false);
        _failure = failure;
        rebuildUi();
      },
      (UserEntity user) {
        setBusy(false);
        _preferences.setCurrentUser = user;
        _preferences.isUserLoggedIn = true;
        _user = user;
        rebuildUi();
      },
    );
  }

  void resetFailure() {
    _failure = null;
  }
}
