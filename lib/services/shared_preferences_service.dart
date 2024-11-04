import 'dart:convert';

import 'package:minimal_app/app/app.logger.dart';
import 'package:minimal_app/modules/login/data/models/user.dart';
import 'package:minimal_app/modules/login/domain/entities/user_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class SharedPreferencesService with InitializableDependency {
  static const _isUserLoggedInKey = 'isUserLoggedIn';
  static const _currentUserKey = 'currentUser';
  static const _tokenKey = 'token';

  final bool enableLogs;
  SharedPreferencesService({this.enableLogs = false});

  final _log = getLogger('SharedPreferencesService');

  late SharedPreferences _preferences;

  @override
  Future<void> init() async {
    _log.d('Initialized');
    _preferences = await SharedPreferences.getInstance();
  }

  bool get isUserLoggedIn =>
      (getFromDisk(_isUserLoggedInKey) as bool?) ?? false;

  String get isTokenKey => (getFromDisk(_tokenKey) as String?) ?? '';

  UserEntity get setCurrentUser {
    if (_preferences.containsKey(_currentUserKey)) {
      return UserModel.fromJson(
              json.decode(getFromDisk(_currentUserKey) as String)
                  as Map<String, dynamic>)
          .toEntity();
    }
    return const UserEntity();
  }

  set isUserLoggedIn(bool value) => saveToDisk(_isUserLoggedInKey, value);
  set isTokenKey(String value) => saveToDisk(_tokenKey, value);

  Set<String> getKeys() => _preferences.getKeys();

  Object? getFromDisk(String key) {
    final value = _preferences.get(key);
    if (enableLogs) _log.v('key:$key value:$value');
    return value;
  }

  set setCurrentUser(UserEntity? user) => saveToDisk(_currentUserKey, user);

  void saveToDisk(String key, dynamic content) {
    if (enableLogs) _log.v('key:$key value:$content');

    if (content is UserEntity) {
      _preferences.setString(
        key,
        json.encode(UserModel.fromEntity(content).toJson()),
      );
    }

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  void dispose() {
    _log.i('');
    _preferences.clear();
  }
}
