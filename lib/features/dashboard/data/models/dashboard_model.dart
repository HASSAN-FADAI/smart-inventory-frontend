import '../../domain/entities/dashboard_entity.dart';

class LowStockItemModel extends LowStockItemEntity {
  const LowStockItemModel({
    required super.id,
    required super.name,
    required super.stockQuantity,
    required super.minStockLevel,
    required super.progress,
  });

  factory LowStockItemModel.fromJson(Map<String, dynamic> json) {
    return LowStockItemModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
      minStockLevel: (json['minStockLevel'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stockQuantity': stockQuantity,
      'minStockLevel': minStockLevel,
      'progress': progress,
    };
  }
}

class RecentSaleModel extends RecentSaleEntity {
  const RecentSaleModel({
    required super.id,
    required super.client,
    required super.products,
    required super.date,
    required super.total,
    required super.status,
  });

  factory RecentSaleModel.fromJson(Map<String, dynamic> json) {
    return RecentSaleModel(
      id: json['id'] as String? ?? '',
      client: json['client'] as String? ?? '',
      products: json['products'] as String? ?? '',
      date: json['date']?.toString() ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client': client,
      'products': products,
      'date': date,
      'total': total,
      'status': status,
    };
  }
}

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.totalProducts,
    required super.totalCategories,
    required super.totalInventoryValue,
    required super.lowStockItemsCount,
    required super.dailySalesTotal,
    required super.lowStockItems,
    required super.recentSales,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalProducts: (json['totalProducts'] as num?)?.toInt() ?? 0,
      totalCategories: (json['totalCategories'] as num?)?.toInt() ?? 0,
      totalInventoryValue:
          (json['totalInventoryValue'] as num?)?.toDouble() ?? 0.0,
      lowStockItemsCount: (json['lowStockItemsCount'] as num?)?.toInt() ?? 0,
      dailySalesTotal: (json['dailySalesTotal'] as num?)?.toDouble() ?? 0.0,
      lowStockItems:
          (json['lowStockItems'] as List<dynamic>?)
              ?.map(
                (e) => LowStockItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      recentSales:
          (json['recentSales'] as List<dynamic>?)
              ?.map((e) => RecentSaleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalProducts': totalProducts,
      'totalCategories': totalCategories,
      'totalInventoryValue': totalInventoryValue,
      'lowStockItemsCount': lowStockItemsCount,
      'dailySalesTotal': dailySalesTotal,
      'lowStockItems': lowStockItems
          .map((e) => (e as LowStockItemModel).toJson())
          .toList(),
      'recentSales': recentSales
          .map((e) => (e as RecentSaleModel).toJson())
          .toList(),
    };
  }
}
