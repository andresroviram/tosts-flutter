import 'package:either_dart/either.dart';
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';
import 'package:minimal_app/modules/home/domain/repositories/home_repositories.dart';

class HomeUseCase {
  HomeUseCase();
  final homeRepository = locator<IHomeRepository>();

  Future<Either<Failure, List<ClientEntity>>> getClients() async =>
      homeRepository.getClients();

  Future<Either<Failure, ClientEntity>> createClient(
          ClientEntity newClient) async =>
      homeRepository.createClient(newClient);

  Future<Either<Failure, bool>> editClient(ClientEntity editClient) async =>
      homeRepository.editClient(editClient);

  Future<Either<Failure, bool>> deleteClient(String id) async =>
      homeRepository.deleteClient(id);
}
