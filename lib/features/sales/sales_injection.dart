import 'package:get_it/get_it.dart';
import 'package:inventory_managment/core/network/api_service.dart';
import 'package:inventory_managment/features/sales/data/datasources/sales_remote_data_source.dart';
import 'package:inventory_managment/features/sales/data/repos/sales_repo_impl.dart';
import 'package:inventory_managment/features/sales/domain/repos/sales_repo.dart';
import 'package:inventory_managment/features/sales/domain/usecases/sales_usecase.dart';
import 'package:inventory_managment/features/sales/presentation/cubit/sales_cubit.dart';

void initSalesInjection(GetIt getIt) {
  getIt.registerLazySingleton<SalesRemoteDataSource>(
    () => SalesRemoteDataSource(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<SalesRepo>(
    () => SalesRepoImpl(getIt<SalesRemoteDataSource>()),
  );

  getIt.registerLazySingleton<SalesUseCase>(
    () => SalesUseCase(getIt<SalesRepo>()),
  );

  getIt.registerFactory<SalesCubit>(
    () => SalesCubit(
      salesUseCase: getIt<SalesUseCase>(),
      productsUseCase: getIt(),
    ),
  );
}
