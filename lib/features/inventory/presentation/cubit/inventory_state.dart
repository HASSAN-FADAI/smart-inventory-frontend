import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import '../../domain/entities/stock_transaction_entity.dart';

abstract class InventoryState {}

class InventoryInitialState extends InventoryState {}

class InventoryLoadingState extends InventoryState {}

class InventoryLoadedState extends InventoryState {
  final List<StockTransactionEntity> transactions;
  final List<ProductEntity> products;

  InventoryLoadedState({required this.transactions, required this.products});
}

class InventoryErrorState extends InventoryState {
  final String message;

  InventoryErrorState(this.message);
}
