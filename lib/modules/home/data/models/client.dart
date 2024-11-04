import 'package:minimal_app/core/utils/extension/extension.dart';
import 'package:minimal_app/modules/home/domain/entities/client_entities.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    super.id,
    super.email,
    super.firstname,
    super.lastname,
    super.address,
    super.photo,
    super.caption,
    super.createdAt,
    super.updatedAt,
    super.userId,
  });
  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json.getString('id'),
        email: json.getString('email'),
        firstname: json.getString('firstname'),
        lastname: json.getString('lastname'),
        address: json.getString('address'),
        photo: json.getString('photo'),
        caption: json.getString('caption'),
        createdAt: json.getDateTime('created_at'),
        updatedAt: json.getDateTime('updated_at'),
        userId: json.getInt('user_id'),
      );

  factory ClientModel.fromEntity(ClientEntity? entity) => ClientModel(
        id: entity?.id,
        email: entity?.email,
        firstname: entity?.firstname,
        lastname: entity?.lastname,
        address: entity?.address,
        photo: entity?.photo,
        caption: entity?.caption,
        createdAt: entity?.createdAt,
        updatedAt: entity?.updatedAt,
        userId: entity?.userId,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (id != null) 'id': id,
        if (email != null) 'email': email,
        if (firstname != null) 'firstname': firstname,
        if (lastname != null) 'lastname': lastname,
        if (address != null) 'address': address,
        if (photo != null) 'photo': photo,
        if (caption != null) 'caption': caption,
        if (createdAt != null) 'created_at': createdAt,
        if (updatedAt != null) 'updated_at': updatedAt,
        if (userId != null) 'user_id': userId,
      };
}

extension ClientMapper on ClientModel {
  ClientEntity toEntity() => ClientEntity(
        id: id,
        email: email,
        firstname: firstname,
        lastname: lastname,
        address: address,
        photo: photo,
        caption: caption,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userId: userId,
      );
}
