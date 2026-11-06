import '../entities/order_entity.dart';

abstract class SalesRepo {
  Future<OrderEntity> createOrder(List<CartItemEntity> items);
  Future<List<OrderEntity>> getOrders();
}
