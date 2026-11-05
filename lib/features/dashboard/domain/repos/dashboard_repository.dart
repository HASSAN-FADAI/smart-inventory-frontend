import '../entities/dashboard_entity.dart';

abstract class DashboardRepo {
  Future<DashboardEntity> getDashboardData();
}
