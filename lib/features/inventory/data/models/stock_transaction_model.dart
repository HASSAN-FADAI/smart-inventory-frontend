import '../../domain/entities/stock_transaction_entity.dart';

class StockTransactionModel extends StockTransactionEntity {
  const StockTransactionModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.type,
    required super.quantity,
    super.reason,
    required super.createdAt,
  });

  factory StockTransactionModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};
    return StockTransactionModel(
      id: json['id']?.toString() ?? '',
      productId:
          json['productId']?.toString() ?? product['id']?.toString() ?? '',
      productName: product['name']?.toString() ?? 'منتج غير معروف',
      type: json['type']?.toString() ?? 'IN',
      quantity: json['quantity'] != null
          ? int.tryParse(json['quantity'].toString()) ?? 0
          : 0,
      reason: json['reason']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
