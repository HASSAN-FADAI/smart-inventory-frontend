import '../../domain/entities/order_entity.dart';
import '../../domain/repos/sales_repo.dart';
import '../datasources/sales_remote_data_source.dart';

class SalesRepoImpl implements SalesRepo {
  final SalesRemoteDataSource remoteDataSource;

  SalesRepoImpl(this.remoteDataSource);

  @override
  Future<OrderEntity> createOrder(List<CartItemEntity> items) async {
    final payload = items
        .map(
          (item) => {'productId': item.product.id, 'quantity': item.quantity},
        )
        .toList();

    return await remoteDataSource.createOrder(payload);
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    return await remoteDataSource.getOrders();
  }
}
