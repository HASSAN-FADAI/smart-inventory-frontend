import 'package:get_it/get_it.dart';
import 'package:inventory_managment/core/network/api_service.dart';
import 'package:inventory_managment/core/network/dio_client.dart';
import 'package:inventory_managment/features/auth/auth_injection.dart';
import 'package:inventory_managment/features/dashboard/dashboard_injection.dart';
import 'package:inventory_managment/features/products/products_injection.dart';

final getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<DioClient>()));

  initAuthInjection(getIt);
  initDashboardInjection(getIt);
  initProductsInjection(getIt);
}
