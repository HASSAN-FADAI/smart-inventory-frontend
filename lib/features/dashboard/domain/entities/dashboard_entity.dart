class LowStockItemEntity {
  final String id;
  final String name;
  final int stockQuantity;
  final int minStockLevel;
  final double progress;

  const LowStockItemEntity({
    required this.id,
    required this.name,
    required this.stockQuantity,
    required this.minStockLevel,
    required this.progress,
  });
}

class RecentSaleEntity {
  final String id;
  final String client;
  final String products;
  final String date;
  final double total;
  final String status;

  const RecentSaleEntity({
    required this.id,
    required this.client,
    required this.products,
    required this.date,
    required this.total,
    required this.status,
  });
}

class DashboardEntity {
  final int totalProducts;
  final int totalCategories;
  final double totalInventoryValue;
  final int lowStockItemsCount;
  final double dailySalesTotal;
  final List<LowStockItemEntity> lowStockItems;
  final List<RecentSaleEntity> recentSales;

  const DashboardEntity({
    required this.totalProducts,
    required this.totalCategories,
    required this.totalInventoryValue,
    required this.lowStockItemsCount,
    required this.dailySalesTotal,
    required this.lowStockItems,
    required this.recentSales,
  });
}
