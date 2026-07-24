import 'package:bloc/bloc.dart';
import 'package:flovix_kitchen/bloc/dashboard/dashboard_event.dart';
import 'package:flovix_kitchen/bloc/dashboard/dashboard_state.dart';
import 'package:flovix_kitchen/bloc/repository/dashboard_repository.dart';
import 'package:flovix_kitchen/main.dart';
import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flovix_kitchen/utils/enums.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.repository}) : super(const DashboardState()) {
    on<LogoutEvent>(_logoutEvent);
  }

  final DashboardRepository repository;

  Future<void> _logoutEvent(
    LogoutEvent event,
    Emitter<DashboardState> emit,
  ) async {
    await SessionController().getUserFromPreference();
    final data = <String, dynamic>{
      'language': isEnglish ? 'en' : 'ar',
      'device_id': SessionController.user.deviceId,
    };

    emit(state.copyWith(logoutEnum: LogoutEnum.loading, message: ''));

    await repository.logoutEvent(data).then((value) {
      emit(state.copyWith(logoutEnum: LogoutEnum.success));
    }).onError((error, stackTrace) {
      emit(
        state.copyWith(
          logoutEnum: LogoutEnum.error,
          message: 'Internal Server Error',
        ),
      );
    });
  }
}
