import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (description != null) 'description': description,
    };
  }
}

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.sku,
    required super.name,
    super.description,
    required super.price,
    required super.costPrice,
    required super.stockQuantity,
    required super.minStockLevel,
    required super.categoryId,
    super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      sku: json['sku'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      costPrice: double.tryParse(json['costPrice']?.toString() ?? '0') ?? 0.0,
      stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
      minStockLevel: (json['minStockLevel'] as num?)?.toInt() ?? 5,
      categoryId: json['categoryId']?.toString() ?? '',
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }
}
