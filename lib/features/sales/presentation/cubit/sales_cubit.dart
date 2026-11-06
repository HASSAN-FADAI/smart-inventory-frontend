import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/core/errors/api_error.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import 'package:inventory_managment/features/products/domain/usecases/products_usecase.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/sales_usecase.dart';
import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  final SalesUseCase salesUseCase;
  final ProductsUseCase productsUseCase;

  Timer? _debounceTimer;
  List<ProductEntity> _allProducts = [];
  List<CategoryEntity> _categories = [];
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';

  final Map<String, int> _cardQuantities = {};
  final List<CartItemEntity> _cartItems = [];

  SalesCubit({required this.salesUseCase, required this.productsUseCase})
    : super(SalesInitial());

  Future<void> loadSalesData({bool forceRefresh = false}) async {
    if (!forceRefresh && _allProducts.isEmpty) {
      emit(SalesLoading());
    }
    try {
      final results = await Future.wait([
        productsUseCase.getProducts(forceRefresh: forceRefresh),
        productsUseCase.getCategories(forceRefresh: forceRefresh),
      ]);

      _allProducts = results[0] as List<ProductEntity>;
      _categories = results[1] as List<CategoryEntity>;

      _emitState();
    } on ApiError catch (e) {
      emit(SalesError(e.message));
    } catch (e) {
      emit(SalesError(e.toString()));
    }
  }

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      _searchQuery = query.trim().toLowerCase();
      _emitState();
    });
  }

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    _emitState();
  }

  // زيادة الكمية على البطاقة مع التحقق من المخزون المتوفر
  void incrementCardQty(ProductEntity product) {
    final currentQty = _cardQuantities[product.id] ?? 0;
    final inCartQty = _getQtyInCart(product.id);

    if (currentQty + inCartQty >= product.stockQuantity) {
      emit(
        SalesError(
          'الكمية المطلوبة تتجاوز المخزون المتوفر (${product.stockQuantity})',
        ),
      );
      _emitState();
      return;
    }

    _cardQuantities[product.id] = currentQty + 1;
    _emitState();
  }

  // إنقاص الكمية على البطاقة
  void decrementCardQty(String productId) {
    final currentQty = _cardQuantities[productId] ?? 0;
    if (currentQty > 0) {
      _cardQuantities[productId] = currentQty - 1;
      _emitState();
    }
  }

  // إضافة المنتج بالكمية المحددة إلى السلة
  void addToCart(ProductEntity product) {
    final qtyToAdd = _cardQuantities[product.id] ?? 0;

    if (qtyToAdd <= 0) {
      emit(SalesError('يرجى تحديد الكمية أولاً (1 على الأقل)'));
      _emitState();
      return;
    }

    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    final currentInCart = existingIndex != -1
        ? _cartItems[existingIndex].quantity
        : 0;

    if (currentInCart + qtyToAdd > product.stockQuantity) {
      emit(
        SalesError(
          'إجمالي الكمية في السلة يتجاوز المخزون المتاح (${product.stockQuantity})',
        ),
      );
      _emitState();
      return;
    }

    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: currentInCart + qtyToAdd,
      );
    } else {
      _cartItems.add(CartItemEntity(product: product, quantity: qtyToAdd));
    }

    // تصفير عداد البطاقة بعد الإضافة للسلة
    _cardQuantities[product.id] = 0;
    _emitState(
      actionMessage: 'تمت إضافة (${qtyToAdd}) من "${product.name}" إلى السلة',
    );
  }

  // تعديل كمية عنصر داخل نافذة السلة
  void updateCartItemQty(String productId, int delta) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index == -1) return;

    final item = _cartItems[index];
    final newQty = item.quantity + delta;

    if (newQty <= 0) {
      _cartItems.removeAt(index);
    } else if (newQty <= item.product.stockQuantity) {
      _cartItems[index] = item.copyWith(quantity: newQty);
    } else {
      emit(
        SalesError(
          'الحد الأقصى المتوفر في المخزون هو ${item.product.stockQuantity}',
        ),
      );
    }
    _emitState();
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    _emitState();
  }

  // إتمام عملية البيع وإرسال الفاتورة للباك إند
  Future<bool> checkout() async {
    if (_cartItems.isEmpty) return false;

    _emitState(isCheckingOut: true);
    try {
      await salesUseCase.createOrder(_cartItems);

      // خصم الكميات المباعة من الكاش المحلي مباشرة بدون طلب GET إضافي
      final Map<String, int> soldMap = {
        for (final item in _cartItems) item.product.id: item.quantity,
      };
      productsUseCase.deductStockLocally(soldMap);

      // تحديث القائمة من الكاش بعد الخصم وتفريغ السلة
      _allProducts = await productsUseCase.getProducts(forceRefresh: false);
      _cartItems.clear();
      _cardQuantities.clear();

      _emitState(
        isCheckingOut: false,
        actionMessage: 'تم إتمام البيع وإصدار الفاتورة بنجاح',
      );
      return true;
    } on ApiError catch (e) {
      emit(SalesError(e.message));
      _emitState(isCheckingOut: false);
      return false;
    } catch (e) {
      emit(SalesError(e.toString()));
      _emitState(isCheckingOut: false);
      return false;
    }
  }

  int _getQtyInCart(String productId) {
    for (final item in _cartItems) {
      if (item.product.id == productId) return item.quantity;
    }
    return 0;
  }

  void _emitState({bool isCheckingOut = false, String? actionMessage}) {
    List<ProductEntity> result = List<ProductEntity>.from(_allProducts);

    if (_selectedCategoryIndex > 0 &&
        _selectedCategoryIndex <= _categories.length) {
      final selectedCategory = _categories[_selectedCategoryIndex - 1];
      result = result
          .where(
            (p) =>
                p.categoryId == selectedCategory.id ||
                p.category?.id == selectedCategory.id,
          )
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      result = result.where((p) {
        final matchSku = p.sku.toLowerCase().contains(_searchQuery);
        final matchName = p.name.toLowerCase().contains(_searchQuery);
        return matchSku || matchName;
      }).toList();
    }

    emit(
      SalesSuccess(
        filteredProducts: result,
        categories: List<CategoryEntity>.from(_categories),
        selectedCategoryIndex: _selectedCategoryIndex,
        cardQuantities: Map<String, int>.from(_cardQuantities),
        cartItems: List<CartItemEntity>.from(_cartItems),
        isCheckingOut: isCheckingOut,
        actionMessage: actionMessage,
      ),
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
