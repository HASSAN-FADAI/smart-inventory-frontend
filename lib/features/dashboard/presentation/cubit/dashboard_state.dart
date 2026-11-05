import 'package:inventory_managment/features/dashboard/domain/entities/dashboard_entity.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final DashboardEntity dashboardData;
  DashboardSuccess(this.dashboardData);
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
