import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/core/errors/api_error.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import 'package:inventory_managment/features/products/domain/usecases/products_usecase.dart';
import '../../domain/entities/stock_transaction_entity.dart';
import '../../domain/usecases/create_transaction_usecase.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final CreateTransactionUseCase createTransactionUseCase;
  final ProductsUseCase productsUseCase;

  List<StockTransactionEntity> allTransactions = [];
  List<ProductEntity> productsList = [];

  InventoryCubit({
    required this.getTransactionsUseCase,
    required this.createTransactionUseCase,
    required this.productsUseCase,
  }) : super(InventoryInitialState());

  Future<void> fetchInventoryData() async {
    emit(InventoryLoadingState());
    try {
      final results = await Future.wait([
        getTransactionsUseCase(),
        productsUseCase.getProducts(),
      ]);
      allTransactions = results[0] as List<StockTransactionEntity>;
      productsList = results[1] as List<ProductEntity>;

      emit(
        InventoryLoadedState(
          transactions: allTransactions,
          products: productsList,
        ),
      );
    } on ApiError catch (e) {
      emit(InventoryErrorState(e.message));
    } catch (e) {
      emit(InventoryErrorState(e.toString()));
    }
  }

  Future<void> createTransaction({
    required String productId,
    required String type,
    required int quantity,
    String? reason,
  }) async {
    emit(InventoryLoadingState());
    try {
      await createTransactionUseCase(
        productId: productId,
        type: type,
        quantity: quantity,
        reason: reason,
      );
      await fetchInventoryData();
    } on ApiError catch (e) {
      emit(InventoryErrorState(e.message));
    } catch (e) {
      emit(InventoryErrorState(e.toString()));
    }
  }
}
