import 'package:minimal_app/app/app.logger.dart';
import 'package:minimal_app/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  // 1. Get the Authentication and NavigationService
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _log = getLogger('StartupVieWModel');

  Future runStartupLogic() async {
    _log.d('isUserLoggedIn:${_authenticationService.userLoggedIn}');
    // 2. Check if the user is logged in
    // if (_authenticationService.userLoggedIn) {
    // 3. Navigate to HomeView
    // _navigationService.replaceWith(Routes.homeView);
    // } else {
    // 4. Or navigate to LoginView
    //   _navigationService.replaceWith(Routes.loginView);
    // }
    _navigationService.replaceWith(Routes.loginView);
  }
}
