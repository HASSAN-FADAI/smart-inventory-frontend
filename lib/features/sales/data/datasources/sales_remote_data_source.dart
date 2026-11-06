import '../../../../core/network/api_service.dart';
import '../models/order_model.dart';

class SalesRemoteDataSource {
  final ApiService apiService;

  SalesRemoteDataSource(this.apiService);

  Future<OrderModel> createOrder(List items) async {
    final response = await apiService.post('/sales', {'items': items});
    return OrderModel.fromJson(response as Map<String, dynamic>);
  }

  Future<List<OrderModel>> getOrders() async {
    final response = await apiService.get('/sales');
    final List data = response as List;
    return data
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
