import '../../domain/entities/stock_transaction_entity.dart';
import '../../domain/repos/inventory_repo.dart';
import '../datasources/inventory_remote_data_source.dart';

class InventoryRepoImpl implements InventoryRepo {
  final InventoryRemoteDataSource remoteDataSource;

  InventoryRepoImpl(this.remoteDataSource);

  @override
  Future<List<StockTransactionEntity>> getTransactions() async {
    return await remoteDataSource.getTransactions();
  }

  @override
  Future<void> createTransaction({
    required String productId,
    required String type,
    required int quantity,
    String? reason,
  }) async {
    await remoteDataSource.createTransaction(
      productId: productId,
      type: type,
      quantity: quantity,
      reason: reason,
    );
  }
}
