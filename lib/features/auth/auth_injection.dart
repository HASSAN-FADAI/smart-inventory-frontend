import 'package:get_it/get_it.dart';
import 'package:inventory_managment/core/network/api_service.dart';
import 'package:inventory_managment/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:inventory_managment/features/auth/data/repos/auth_repo_impl.dart';
import 'package:inventory_managment/features/auth/domain/repos/auth_repo.dart';
import 'package:inventory_managment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:inventory_managment/features/auth/presentation/cubit/auth_cubit.dart';

void initAuthInjection(GetIt getIt) {
  // Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<ApiService>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthRemoteDataSource>()),
  );

  // Use Case
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(getIt<AuthRepo>()),
  );

  // Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<AuthUseCase>(),
      registerUseCase: getIt<AuthUseCase>(),
      logoutUseCase: getIt<AuthUseCase>(),
    ),
  );
}
