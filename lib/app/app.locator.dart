// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../modules/home/data/datasources/home_datasources.dart';
import '../modules/home/data/repository/home_repository.dart';
import '../modules/home/domain/repositories/home_repositories.dart';
import '../modules/home/domain/usecases/home_usecases.dart';
import '../modules/login/data/datasources/login_datasources.dart';
import '../modules/login/data/repository/login_repository.dart';
import '../modules/login/domain/repositories/login_repositories.dart';
import '../modules/login/domain/usecases/login_usecases.dart';
import '../services/authentication_service.dart';
import '../services/base_client_service.dart';
import '../services/shared_preferences_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.init();
  locator.registerSingleton(sharedPreferencesService);

  locator.registerLazySingleton(() => BaseClientService());
  locator.registerLazySingleton(() => LoginUseCase());
  locator.registerLazySingleton(() => HomeUseCase());
  locator.registerFactory<ILoginDatasource>(() => FactoryLoginDatasource());
  locator.registerFactory<ILoginRepository>(() => LoginRepository());
  locator.registerFactory<IHomeDatasource>(() => FactoryHomeDatasource());
  locator.registerFactory<IHomeRepository>(() => HomeRepository());
}
