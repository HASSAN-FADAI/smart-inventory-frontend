import '../../../../core/network/api_service.dart';
import '../models/product_model.dart';

class ProductsRemoteDataSource {
  final ApiService apiService;

  ProductsRemoteDataSource(this.apiService);

  Future<List<ProductModel>> getProducts() async {
    final response = await apiService.get('/products');
    final List data = response as List;
    return data
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiService.get('/categories');
    final List data = response as List;
    return data
        .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<CategoryModel> createCategory({
    required String name,
    String? description,
  }) async {
    final response = await apiService.post('/categories', {
      'name': name,
      if (description != null && description.isNotEmpty)
        'description': description,
    });
    return CategoryModel.fromJson(response as Map<String, dynamic>);
  }

  Future<ProductModel> createProduct({
    required String name,
    required String sku,
    String? description,
    required double price,
    required double costPrice,
    required int stockQuantity,
    required int minStockLevel,
    required String categoryId,
  }) async {
    final response = await apiService.post('/products', {
      'name': name,
      'sku': sku,
      if (description != null && description.isNotEmpty)
        'description': description,
      'price': price,
      'costPrice': costPrice,
      'stockQuantity': stockQuantity,
      'minStockLevel': minStockLevel,
      'categoryId': categoryId,
    });
    return ProductModel.fromJson(response as Map<String, dynamic>);
  }

  Future<ProductModel> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await apiService.patch('/products/$id', data);
    return ProductModel.fromJson(response as Map<String, dynamic>);
  }

  Future<void> deleteProduct(String id) async {
    await apiService.delete('/products/$id', {});
  }

  Future<void> deleteCategory(String id) async {
    await apiService.delete('/categories/$id', {});
  }
}
