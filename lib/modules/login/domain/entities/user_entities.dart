class UserEntity {
  const UserEntity({
    this.id,
    this.email,
    this.password,
    this.accessToken,
    this.tokenType,
    this.auth = false,
  });

  final String? id;
  final String? email;
  final String? password;
  final String? accessToken;
  final String? tokenType;

  // used for indicate if client logged in or not
  final bool auth;

  UserEntity copyWith({
    String? id,
    String? email,
    String? password,
    String? accessToken,
    String? tokenType,
    bool? auth,
  }) =>
      UserEntity(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        auth: auth ?? this.auth,
      );
}
