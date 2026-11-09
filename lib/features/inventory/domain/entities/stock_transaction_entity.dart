class StockTransactionEntity {
  final String id;
  final String productId;
  final String productName;
  final String type;
  final int quantity;
  final String? reason;
  final DateTime createdAt;

  const StockTransactionEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.quantity,
    this.reason,
    required this.createdAt,
  });
}
