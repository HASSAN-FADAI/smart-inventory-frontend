import 'package:inventory_managment/features/dashboard/domain/repos/dashboard_repository.dart';

import '../entities/dashboard_entity.dart';

class DashboardUseCase {
  final DashboardRepo dashboardRepo;

  const DashboardUseCase(this.dashboardRepo);

  Future<DashboardEntity> getDashboardData() async {
    return await dashboardRepo.getDashboardData();
  }
}
