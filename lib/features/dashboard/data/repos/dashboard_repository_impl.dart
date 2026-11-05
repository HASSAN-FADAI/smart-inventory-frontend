import 'package:inventory_managment/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:inventory_managment/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:inventory_managment/features/dashboard/domain/repos/dashboard_repository.dart';

class DashboardRepoImpl implements DashboardRepo {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepoImpl(this.remoteDataSource);

  @override
  Future<DashboardEntity> getDashboardData() async {
    final dashboardData = await remoteDataSource.getDashboardData();
    return dashboardData;
  }
}
