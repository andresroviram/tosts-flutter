import 'package:either_dart/either.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/modules/login/domain/entities/user_entities.dart';

abstract class ILoginRepository {
  Future<Either<Failure, UserEntity>> login(UserEntity? user);
}
