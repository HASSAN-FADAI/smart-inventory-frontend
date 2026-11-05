import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/core/errors/api_error.dart';
import 'package:inventory_managment/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardUseCase dashboardUseCase;

  DashboardCubit({required this.dashboardUseCase}) : super(DashboardInitial());

  Future<void> getDashboardData() async {
    emit(DashboardLoading());
    try {
      final data = await dashboardUseCase.getDashboardData();
      emit(DashboardSuccess(data));
    } on ApiError catch (e) {
      emit(DashboardError(e.message));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
