import 'package:get_it/get_it.dart';
import 'package:inventory_managment/features/products/domain/usecases/products_usecase.dart';
import '../../../core/network/api_service.dart';
import 'data/datasources/inventory_remote_data_source.dart';
import 'data/repos/inventory_repo_impl.dart';
import 'domain/repos/inventory_repo.dart';
import 'domain/usecases/create_transaction_usecase.dart';
import 'domain/usecases/get_transactions_usecase.dart';
import 'presentation/cubit/inventory_cubit.dart';

void initInventoryInjection(GetIt getIt) {
  getIt.registerLazySingleton<InventoryRemoteDataSource>(
    () => InventoryRemoteDataSource(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<InventoryRepo>(
    () => InventoryRepoImpl(getIt<InventoryRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(getIt<InventoryRepo>()),
  );

  getIt.registerLazySingleton<CreateTransactionUseCase>(
    () => CreateTransactionUseCase(getIt<InventoryRepo>()),
  );

  getIt.registerFactory<InventoryCubit>(
    () => InventoryCubit(
      getTransactionsUseCase: getIt<GetTransactionsUseCase>(),
      createTransactionUseCase: getIt<CreateTransactionUseCase>(),
      productsUseCase: getIt<ProductsUseCase>(),
    ),
  );
}
