import 'package:either_dart/either.dart';
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/modules/login/domain/entities/user_entities.dart';
import 'package:minimal_app/modules/login/domain/repositories/login_repositories.dart';

class LoginUseCase {
  LoginUseCase();
  final loginRepository = locator<ILoginRepository>();

  Future<Either<Failure, UserEntity>> login(UserEntity? user) async =>
      loginRepository.login(user);
}
