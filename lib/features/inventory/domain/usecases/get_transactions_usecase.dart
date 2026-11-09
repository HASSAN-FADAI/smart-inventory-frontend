import '../entities/stock_transaction_entity.dart';
import '../repos/inventory_repo.dart';

class GetTransactionsUseCase {
  final InventoryRepo repo;

  const GetTransactionsUseCase(this.repo);

  Future<List<StockTransactionEntity>> call() async {
    return await repo.getTransactions();
  }
}
