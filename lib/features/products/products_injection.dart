import 'package:get_it/get_it.dart';
import 'package:inventory_managment/core/network/api_service.dart';
import 'package:inventory_managment/features/products/data/datasource/products_remote_data_source.dart';
import 'package:inventory_managment/features/products/data/repos/products_repo_impl.dart';
import 'package:inventory_managment/features/products/domain/repos/products_repo.dart';
import 'package:inventory_managment/features/products/domain/usecases/products_usecase.dart';
import 'package:inventory_managment/features/products/presentation/cubit/products_cubit.dart';

void initProductsInjection(GetIt getIt) {
  getIt.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSource(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ProductsRepo>(
    () => ProductsRepoImpl(getIt<ProductsRemoteDataSource>()),
  );

  getIt.registerLazySingleton<ProductsUseCase>(
    () => ProductsUseCase(getIt<ProductsRepo>()),
  );

  getIt.registerFactory<ProductsCubit>(
    () => ProductsCubit(productsUseCase: getIt<ProductsUseCase>()),
  );
}
