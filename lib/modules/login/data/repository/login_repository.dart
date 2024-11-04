import 'package:either_dart/either.dart';
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/modules/login/data/datasources/login_datasources.dart';
import 'package:minimal_app/modules/login/data/models/user.dart';
import 'package:minimal_app/modules/login/domain/entities/user_entities.dart';
import 'package:minimal_app/modules/login/domain/repositories/login_repositories.dart';

class LoginRepository implements ILoginRepository {
  LoginRepository();

  final loginDatasource = locator<ILoginDatasource>();

  @override
  Future<Either<Failure, UserEntity>> login(UserEntity? user) async {
    try {
      UserModel setting = await loginDatasource.login(user);
      return Right(setting.toEntity());
    } on BaseClientException catch (e) {
      if (e.type == 'SocketException') {
        return const Left(NetworkFailure());
      }
      if (e.type == 'TimeoutException') {
        return const Left(TimeOutFailure());
      }
      if (e.type == 'UnAuthorization') {
        return const Left(AuthFailure());
      }
      return Left(
        AnotherFailure(
          codeError: e.statusCode ?? 0,
          message: e.message ?? '',
        ),
      );
    } on Error catch (_) {
      return const Left(AnotherFailure());
    }
  }
}
