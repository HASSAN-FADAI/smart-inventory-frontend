import '../entities/order_entity.dart';
import '../repos/sales_repo.dart';

class SalesUseCase {
  final SalesRepo salesRepo;

  const SalesUseCase(this.salesRepo);

  Future<OrderEntity> createOrder(List<CartItemEntity> items) async {
    return await salesRepo.createOrder(items);
  }

  Future<List<OrderEntity>> getOrders() async {
    return await salesRepo.getOrders();
  }
}
