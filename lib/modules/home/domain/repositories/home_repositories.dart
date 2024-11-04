import 'package:either_dart/either.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<ClientEntity>>> getClients();
  Future<Either<Failure, ClientEntity>> createClient(ClientEntity newClient);
  Future<Either<Failure, bool>> editClient(ClientEntity editClient);
  Future<Either<Failure, bool>> deleteClient(String id);
}
