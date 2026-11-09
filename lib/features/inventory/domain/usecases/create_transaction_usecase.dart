import '../repos/inventory_repo.dart';

class CreateTransactionUseCase {
  final InventoryRepo repo;

  const CreateTransactionUseCase(this.repo);

  Future<void> call({
    required String productId,
    required String type,
    required int quantity,
    String? reason,
  }) async {
    return await repo.createTransaction(
      productId: productId,
      type: type,
      quantity: quantity,
      reason: reason,
    );
  }
}
