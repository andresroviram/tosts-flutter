class ClientEntity {
  const ClientEntity({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.photo,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? address;
  final String? photo;
  final String? caption;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;

  ClientEntity copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? address,
    String? photo,
    String? caption,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
  }) =>
      ClientEntity(
        id: id ?? this.id,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        address: address ?? this.address,
        photo: photo ?? this.photo,
        caption: caption ?? this.caption,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );
}
