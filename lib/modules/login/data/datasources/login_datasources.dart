import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/core/endpoint.dart';
import 'package:minimal_app/core/utils/extension/extension.dart';
import 'package:minimal_app/modules/login/data/models/user.dart';
import 'package:minimal_app/modules/login/domain/entities/user_entities.dart';
import 'package:minimal_app/services/base_client_service.dart';

abstract class ILoginDatasource {
  Future<UserModel> login(UserEntity? user);
}

class FactoryLoginDatasource implements ILoginDatasource {
  FactoryLoginDatasource();

  final _baseClient = locator<BaseClientService>();

  @override
  Future<UserModel> login(UserEntity? user) async {
    try {
      return (await _baseClient.post(
        path: EndPoint.login,
        body: UserModel.fromEntity(user).toJson(),
        isHeader: false,
      ))!
          .withConverter<UserModel>(
        callback: UserModel.fromJson,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
}
