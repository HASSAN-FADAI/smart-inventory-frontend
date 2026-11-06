import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';

abstract class ProductsRepo {
  Future<List<ProductEntity>> getProducts({bool forceRefresh = false});
  Future<List<CategoryEntity>> getCategories({bool forceRefresh = false});

  Future<CategoryEntity> createCategory({
    required String name,
    String? description,
  });

  Future<ProductEntity> createProduct({
    required String name,
    required String sku,
    String? description,
    required double price,
    required double costPrice,
    required int stockQuantity,
    required int minStockLevel,
    required String categoryId,
  });
  Future<ProductEntity> updateProduct(String id, Map<String, dynamic> data);

  Future<void> deleteProduct(String id);
  Future<void> deleteCategory(String id);
}
