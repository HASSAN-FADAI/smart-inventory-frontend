import 'package:get_it/get_it.dart';
import 'package:inventory_managment/core/network/api_service.dart';
import 'package:inventory_managment/core/network/dio_client.dart';
import 'package:inventory_managment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:inventory_managment/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:inventory_managment/features/dashboard/data/repos/dashboard_repository_impl.dart';
import 'package:inventory_managment/features/dashboard/domain/repos/dashboard_repository.dart';
import 'package:inventory_managment/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:inventory_managment/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<DioClient>()));

  // Auth - Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<ApiService>()),
  );

  // Auth - Repo
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthRemoteDataSource>()),
  );

  // Auth - UseCases
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(getIt<AuthRepo>()),
  );

  // Auth - Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<AuthUseCase>(),
      registerUseCase: getIt<AuthUseCase>(),
    ),
  );

  //Dashboard

  // 1. Remote Data Source
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(getIt<ApiService>()),
  );

  // 2. Repository
  getIt.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImpl(getIt<DashboardRemoteDataSource>()),
  );

  // 3. UseCase
  getIt.registerLazySingleton<DashboardUseCase>(
    () => DashboardUseCase(getIt<DashboardRepo>()),
  );

  // 4. Cubit
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(dashboardUseCase: getIt<DashboardUseCase>()),
  );
}
