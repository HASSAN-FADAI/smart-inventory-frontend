class CategoryEntity {
  final String id;
  final String name;
  final String? description;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
  });
}

class ProductEntity {
  final String id;
  final String sku;
  final String name;
  final String? description;
  final double price;
  final double costPrice;
  final int stockQuantity;
  final int minStockLevel;
  final String categoryId;
  final CategoryEntity? category;

  const ProductEntity({
    required this.id,
    required this.sku,
    required this.name,
    this.description,
    required this.price,
    required this.costPrice,
    required this.stockQuantity,
    required this.minStockLevel,
    required this.categoryId,
    this.category,
  });
}
