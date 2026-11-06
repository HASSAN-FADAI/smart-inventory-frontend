import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({required this.product, required this.quantity});

  double get subTotal => product.price * quantity;

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class OrderItemEntity {
  final String id;
  final String productId;
  final int quantity;
  final double unitPrice;

  const OrderItemEntity({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  });
}

class OrderEntity {
  final String id;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.items,
  });
}
