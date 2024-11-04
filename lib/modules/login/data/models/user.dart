import 'package:minimal_app/core/utils/extension/extension.dart';
import 'package:minimal_app/modules/login/domain/entities/user_entities.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.email,
    super.password,
    super.accessToken,
    super.tokenType,
    super.auth,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json.getString('id'),
        email: json.getString('email'),
        accessToken: json.getString('access_token'),
        tokenType: json.getString('token_type'),
      );

  factory UserModel.fromEntity(UserEntity? entity) => UserModel(
        id: entity?.id,
        email: entity?.email,
        password: entity?.password,
        accessToken: entity?.accessToken,
        tokenType: entity?.tokenType,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'email': email,
        'password': password,
        'access_token': accessToken,
        'token_type': tokenType,
      };
}

extension UserMapper on UserModel {
  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        accessToken: accessToken,
        tokenType: tokenType,
      );
}
