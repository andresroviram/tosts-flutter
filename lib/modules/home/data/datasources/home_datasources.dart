import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/endpoint.dart';
import 'package:minimal_app/core/utils/extension/extension.dart';
import 'package:minimal_app/modules/home/data/models/client.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';
import 'package:minimal_app/services/base_client_service.dart';

abstract class IHomeDatasource {
  Future<List<ClientModel>> getClients();
  Future<ClientModel> createClient(ClientEntity newClient);
  Future<bool> editClient(ClientEntity editClient);
  Future<bool> deleteClient(String id);
}

class FactoryHomeDatasource implements IHomeDatasource {
  FactoryHomeDatasource();

  final _baseClient = locator<BaseClientService>();

  @override
  Future<List<ClientModel>> getClients() async {
    try {
      return (await _baseClient.get(
        path: EndPoint.getClients,
      ))!
          .withListConverterFromKey<ClientModel>(
        'data',
        callback: ClientModel.fromJson,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<ClientModel> createClient(ClientEntity newClient) async {
    try {
      return (await _baseClient.post(
        path: EndPoint.createClient,
        body: ClientModel.fromEntity(newClient).toJson(),
      ))!
          .withConverter<ClientModel>(
        callback: ClientModel.fromJson,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> editClient(ClientEntity editClient) async {
    try {
      Map<String, dynamic> response = (await _baseClient.put(
        path: EndPoint.editClient.toParamUrl(<String, String>{
          'id': editClient.id.toString(),
        })!,
        body: ClientModel.fromEntity(editClient).toJson(),
      ))!
          .withConverter<Map<String, dynamic>>(callback: (json) => json);
      return response['success'] as bool;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteClient(String id) async {
    try {
      Map<String, dynamic> response = (await _baseClient.delete(
        path: EndPoint.deleteClient.toParamUrl(<String, String>{
          'id': id,
        })!,
      ))!
          .withConverter<Map<String, dynamic>>(callback: (json) => json);
      return response['success'] as bool;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
