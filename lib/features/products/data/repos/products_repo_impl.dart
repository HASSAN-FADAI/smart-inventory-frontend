import 'package:inventory_managment/features/products/data/datasource/products_remote_data_source.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';

import '../../domain/repos/products_repo.dart';
import '../models/product_model.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepoImpl(this.remoteDataSource);

  // الكاش المحلي لتقليل الطلبات
  List<ProductEntity>? _cachedProducts;
  List<CategoryEntity>? _cachedCategories;

  @override
  Future<List<ProductEntity>> getProducts({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedProducts != null) {
      return _cachedProducts!;
    }
    final products = await remoteDataSource.getProducts();
    _cachedProducts = List<ProductEntity>.from(products);
    return _cachedProducts!;
  }

  @override
  Future<List<CategoryEntity>> getCategories({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedCategories != null) {
      return _cachedCategories!;
    }
    final categories = await remoteDataSource.getCategories();
    _cachedCategories = List<CategoryEntity>.from(categories);
    return _cachedCategories!;
  }

  @override
  Future<CategoryEntity> createCategory({
    required String name,
    String? description,
  }) async {
    final newCategory = await remoteDataSource.createCategory(
      name: name,
      description: description,
    );
    // تحديث الكاش محلياً فوراً دون طلب جديد للسيرفر
    if (_cachedCategories != null) {
      _cachedCategories!.add(newCategory);
    }
    return newCategory;
  }

  @override
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
    final createdModel = await remoteDataSource.createProduct(
      name: name,
      sku: sku,
      description: description,
      price: price,
      costPrice: costPrice,
      stockQuantity: stockQuantity,
      minStockLevel: minStockLevel,
      categoryId: categoryId,
    );

    CategoryEntity? matchedCategory = createdModel.category;
    if (matchedCategory == null && _cachedCategories != null) {
      for (final cat in _cachedCategories!) {
        if (cat.id == categoryId) {
          matchedCategory = cat;
          break;
        }
      }
    }

    final fullProduct = ProductModel(
      id: createdModel.id,
      sku: createdModel.sku,
      name: createdModel.name,
      description: createdModel.description,
      price: createdModel.price,
      costPrice: createdModel.costPrice,
      stockQuantity: createdModel.stockQuantity,
      minStockLevel: createdModel.minStockLevel,
      categoryId: createdModel.categoryId,
      category: matchedCategory,
    );

    if (_cachedProducts != null) {
      _cachedProducts!.insert(0, fullProduct);
    }
    return fullProduct;
  }

  @override
  Future<void> deleteProduct(String id) async {
    await remoteDataSource.deleteProduct(id);
    if (_cachedProducts != null) {
      _cachedProducts!.removeWhere((p) => p.id == id);
    }
  }

  @override
  Future<ProductEntity> updateProduct(
    String id,
    Map<String, dynamic> data,
  ) async {
    final updatedModel = await remoteDataSource.updateProduct(id, data);

    CategoryEntity? matchedCategory = updatedModel.category;
    if (matchedCategory == null &&
        _cachedCategories != null &&
        data['categoryId'] != null) {
      for (final cat in _cachedCategories!) {
        if (cat.id == data['categoryId']) {
          matchedCategory = cat;
          break;
        }
      }
    }

    final fullProduct = ProductModel(
      id: updatedModel.id,
      sku: updatedModel.sku,
      name: updatedModel.name,
      description: updatedModel.description,
      price: updatedModel.price,
      costPrice: updatedModel.costPrice,
      stockQuantity: updatedModel.stockQuantity,
      minStockLevel: updatedModel.minStockLevel,
      categoryId: updatedModel.categoryId,
      category: matchedCategory ?? updatedModel.category,
    );

    if (_cachedProducts != null) {
      final index = _cachedProducts!.indexWhere((p) => p.id == id);
      if (index != -1) {
        _cachedProducts![index] = fullProduct;
      }
    }
    return fullProduct;
  }

  @override
  Future<void> deleteCategory(String id) async {
    await remoteDataSource.deleteCategory(id);
    if (_cachedCategories != null) {
      _cachedCategories!.removeWhere((c) => c.id == id);
    }
  }
}
