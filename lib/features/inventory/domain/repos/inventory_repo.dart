import '../entities/stock_transaction_entity.dart';

abstract class InventoryRepo {
  Future<List<StockTransactionEntity>> getTransactions();
  Future<void> createTransaction({
    required String productId,
    required String type,
    required int quantity,
    String? reason,
  });
}
