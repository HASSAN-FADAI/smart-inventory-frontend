import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';

import '../repos/products_repo.dart';

class ProductsUseCase {
  final ProductsRepo productsRepo;

  const ProductsUseCase(this.productsRepo);

  Future<List<ProductEntity>> getProducts({bool forceRefresh = false}) async {
    return await productsRepo.getProducts(forceRefresh: forceRefresh);
  }

  Future<List<CategoryEntity>> getCategories({
    bool forceRefresh = false,
  }) async {
    return await productsRepo.getCategories(forceRefresh: forceRefresh);
  }

  Future<CategoryEntity> createCategory({
    required String name,
    String? description,
  }) async {
    return await productsRepo.createCategory(
      name: name,
      description: description,
    );
  }

  Future<ProductEntity> createProduct({
    required String name,
    required String sku,
    String? description,
    required double price,
    required double costPrice,
    required int stockQuantity,
    required int minStockLevel,
    required String categoryId,
  }) async {
    return await productsRepo.createProduct(
      name: name,
      sku: sku,
      description: description,
      price: price,
      costPrice: costPrice,
      stockQuantity: stockQuantity,
      minStockLevel: minStockLevel,
      categoryId: categoryId,
    );
  }

  Future<ProductEntity> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    return await productsRepo.updateProduct(id, data);
  }

  Future<void> deleteProduct(String id) async {
    return await productsRepo.deleteProduct(id);
  }

  Future<void> deleteCategory(String id) async {
    return await productsRepo.deleteCategory(id);
  }
}
