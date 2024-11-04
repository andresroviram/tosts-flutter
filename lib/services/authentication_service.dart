import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/services/shared_preferences_service.dart';

class AuthenticationService {
  final _preferences = locator<SharedPreferencesService>();
  bool get userLoggedIn => _preferences.isUserLoggedIn;
}
