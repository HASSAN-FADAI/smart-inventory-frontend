import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import '../../domain/entities/order_entity.dart';

abstract class SalesState {}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesSuccess extends SalesState {
  final List<ProductEntity> filteredProducts;
  final List<CategoryEntity> categories;
  final int selectedCategoryIndex;
  final Map<String, int> cardQuantities;
  final List<CartItemEntity> cartItems;
  final bool isCheckingOut;
  final String? actionMessage;

  SalesSuccess({
    required this.filteredProducts,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.cardQuantities,
    required this.cartItems,
    this.isCheckingOut = false,
    this.actionMessage,
  });

  int get totalCartCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalCartAmount =>
      cartItems.fold(0.0, (sum, item) => sum + item.subTotal);
}

class SalesError extends SalesState {
  final String message;
  SalesError(this.message);
}
