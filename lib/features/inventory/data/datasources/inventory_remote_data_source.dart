import '../../../../core/network/api_service.dart';
import '../models/stock_transaction_model.dart';

class InventoryRemoteDataSource {
  final ApiService apiService;

  InventoryRemoteDataSource(this.apiService);

  Future<List<StockTransactionModel>> getTransactions() async {
    final response = await apiService.get('/inventory/transactions');
    if (response is List) {
      return response
          .map((item) => StockTransactionModel.fromJson(item))
          .toList();
    }
    return [];
  }

  Future<void> createTransaction({
    required String productId,
    required String type,
    required int quantity,
    String? reason,
  }) async {
    await apiService.post('/inventory/transactions', {
      'productId': productId,
      'type': type,
      'quantity': quantity,
      if (reason != null && reason.isNotEmpty) 'reason': reason,
    });
  }
}
