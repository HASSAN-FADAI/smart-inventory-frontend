import '../../../../core/network/api_service.dart';
import '../models/dashboard_model.dart';

class DashboardRemoteDataSource {
  final ApiService apiService;

  DashboardRemoteDataSource(this.apiService);

  Future<DashboardModel> getDashboardData() async {
    final response = await apiService.get('/dashboard');
    return DashboardModel.fromJson(response);
  }
}
