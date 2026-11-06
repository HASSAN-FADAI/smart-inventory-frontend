import 'package:get_it/get_it.dart';
import 'package:inventory_managment/core/network/api_service.dart';
import 'package:inventory_managment/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:inventory_managment/features/dashboard/data/repos/dashboard_repository_impl.dart';
import 'package:inventory_managment/features/dashboard/domain/repos/dashboard_repository.dart';
import 'package:inventory_managment/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:inventory_managment/features/dashboard/presentation/cubit/dashboard_cubit.dart';

void initDashboardInjection(GetIt getIt) {
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImpl(getIt<DashboardRemoteDataSource>()),
  );

  getIt.registerLazySingleton<DashboardUseCase>(
    () => DashboardUseCase(getIt<DashboardRepo>()),
  );

  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(dashboardUseCase: getIt<DashboardUseCase>()),
  );
}
