import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsActionLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductEntity> filteredProducts;
  final List<CategoryEntity> categories;
  final int selectedCategoryIndex;
  final String? actionMessage;

  ProductsSuccess({
    required this.filteredProducts,
    required this.categories,
    required this.selectedCategoryIndex,
    this.actionMessage,
  });
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
