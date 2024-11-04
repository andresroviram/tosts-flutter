import 'package:minimal_app/modules/home/data/datasources/home_datasources.dart';
import 'package:minimal_app/modules/home/data/repository/home_repository.dart';
import 'package:minimal_app/modules/home/domain/repositories/home_repositories.dart';
import 'package:minimal_app/modules/home/domain/usecases/home_usecases.dart';
import 'package:minimal_app/modules/login/data/datasources/login_datasources.dart';
import 'package:minimal_app/modules/login/data/repository/login_repository.dart';
import 'package:minimal_app/modules/login/domain/repositories/login_repositories.dart';
import 'package:minimal_app/modules/login/domain/usecases/login_usecases.dart';
import 'package:minimal_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:minimal_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:minimal_app/ui/views/home/home_view.dart';
import 'package:minimal_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:minimal_app/ui/views/login/login_view.dart';
import 'package:minimal_app/services/authentication_service.dart';
import 'package:minimal_app/services/shared_preferences_service.dart';
import 'package:minimal_app/services/base_client_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    InitializableSingleton(classType: SharedPreferencesService),
    LazySingleton(classType: BaseClientService),
    LazySingleton(classType: LoginUseCase),
    LazySingleton(classType: HomeUseCase),
    Factory(classType: FactoryLoginDatasource, asType: ILoginDatasource),
    Factory(classType: LoginRepository, asType: ILoginRepository),
    Factory(classType: FactoryHomeDatasource, asType: IHomeDatasource),
    Factory(classType: HomeRepository, asType: IHomeRepository),
// @stacked-service
  ],
  logger: StackedLogger(),
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
