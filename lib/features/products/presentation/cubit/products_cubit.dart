import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/core/errors/api_error.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import 'package:inventory_managment/features/products/presentation/cubit/products_stata.dart';
import '../../domain/usecases/products_usecase.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsUseCase productsUseCase;

  Timer? _debounceTimer;
  List<ProductEntity> _allProducts = [];
  List<CategoryEntity> _categories = [];
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';

  ProductsCubit({required this.productsUseCase}) : super(ProductsInitial());

  Future<void> loadInitialData({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      emit(ProductsLoading());
    }
    try {
      final results = await Future.wait([
        productsUseCase.getProducts(forceRefresh: forceRefresh),
        productsUseCase.getCategories(forceRefresh: forceRefresh),
      ]);

      _allProducts = results[0] as List<ProductEntity>;
      _categories = results[1] as List<CategoryEntity>;

      _emitFilteredState();
    } on ApiError catch (e) {
      emit(ProductsError(e.message));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      _searchQuery = query.trim().toLowerCase();
      _emitFilteredState();
    });
  }

  // تغيير القسم المختار
  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    _emitFilteredState();
  }

  // إضافة فئة جديدة وتحديث الواجهة لحظياً
  Future<bool> addCategory({required String name, String? description}) async {
    try {
      await productsUseCase.createCategory(
        name: name,
        description: description,
      );
      _categories = await productsUseCase.getCategories(forceRefresh: false);
      _emitFilteredState(actionMessage: 'تمت إضافة الفئة بنجاح');
      return true;
    } on ApiError catch (e) {
      emit(ProductsError(e.message));
      _emitFilteredState();
      return false;
    } catch (e) {
      emit(ProductsError(e.toString()));
      _emitFilteredState();
      return false;
    }
  }

  // إضافة منتج جديد وتحديث الواجهة لحظياً
  Future<bool> addProduct({
    required String name,
    required String sku,
    String? description,
    required double price,
    required double costPrice,
    required int stockQuantity,
    required int minStockLevel,
    required String categoryId,
  }) async {
    try {
      await productsUseCase.createProduct(
        name: name,
        sku: sku,
        description: description,
        price: price,
        costPrice: costPrice,
        stockQuantity: stockQuantity,
        minStockLevel: minStockLevel,
        categoryId: categoryId,
      );
      _allProducts = await productsUseCase.getProducts(forceRefresh: false);
      _emitFilteredState(actionMessage: 'تمت إضافة المنتج بنجاح');
      return true;
    } on ApiError catch (e) {
      emit(ProductsError(e.message));
      _emitFilteredState();
      return false;
    } catch (e) {
      emit(ProductsError(e.toString()));
      _emitFilteredState();
      return false;
    }
  }

  Future<bool> updateProduct(String id, Map<String, dynamic> data) async {
    try {
      await productsUseCase.updateProduct(id, data);
      _emitFilteredState(actionMessage: 'تم تعديل المنتج بنجاح');
      return true;
    } on ApiError catch (e) {
      emit(ProductsError(e.message));
      _emitFilteredState();
      return false;
    } catch (e) {
      emit(ProductsError(e.toString()));
      _emitFilteredState();
      return false;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await productsUseCase.deleteProduct(id);
      _allProducts = await productsUseCase.getProducts(forceRefresh: false);
      _emitFilteredState(actionMessage: 'تم حذف المنتج بنجاح');
    } on ApiError catch (e) {
      emit(ProductsError(e.message));
      _emitFilteredState();
    } catch (e) {
      emit(ProductsError(e.toString()));
      _emitFilteredState();
    }
  }

  void _emitFilteredState({String? actionMessage}) {
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
      ProductsSuccess(
        filteredProducts: result,
        categories: List<CategoryEntity>.from(_categories),
        selectedCategoryIndex: _selectedCategoryIndex,
        actionMessage: actionMessage,
      ),
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> deleteCategory(String id) async {
    try {
      await productsUseCase.deleteCategory(id);
      _categories = await productsUseCase.getCategories(forceRefresh: false);

      if (_selectedCategoryIndex > _categories.length) {
        _selectedCategoryIndex = 0;
      }

      _emitFilteredState(actionMessage: 'تم حذف الفئة بنجاح');
    } on ApiError catch (e) {
      emit(ProductsError(e.message));
      _emitFilteredState();
    } catch (e) {
      emit(ProductsError(e.toString()));
      _emitFilteredState();
    }
  }
}
