import 'package:either_dart/either.dart';
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/modules/home/data/datasources/home_datasources.dart';
import 'package:minimal_app/modules/home/data/models/client.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';
import 'package:minimal_app/modules/home/domain/repositories/home_repositories.dart';

class HomeRepository implements IHomeRepository {
  HomeRepository();

  final homeDatasource = locator<IHomeDatasource>();

  @override
  Future<Either<Failure, List<ClientEntity>>> getClients() async {
    try {
      List<ClientModel> client = await homeDatasource.getClients();
      final List<ClientEntity> list = client.map((e) => e.toEntity()).toList();
      return Right(list);
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

  @override
  Future<Either<Failure, ClientEntity>> createClient(
      ClientEntity newClient) async {
    try {
      ClientModel client = await homeDatasource.createClient(newClient);
      return Right(client.toEntity());
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

  @override
  Future<Either<Failure, bool>> editClient(ClientEntity editClient) async {
    try {
      bool success = await homeDatasource.editClient(editClient);
      return Right(success);
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

  @override
  Future<Either<Failure, bool>> deleteClient(String id) async {
    try {
      bool success = await homeDatasource.deleteClient(id);
      return Right(success);
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
