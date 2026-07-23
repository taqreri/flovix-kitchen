import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flovix_kitchen/bloc/repository/login_repository.dart';
import 'package:flovix_kitchen/main.dart';
import 'package:flovix_kitchen/notification_services/notification_service.dart';


import '../../../services/session_manager/session_controller.dart';
import '../../../utils/app_url.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/enums.dart';
import '../../../utils/network/network_services.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository authApiRepository;
  LoginBloc({required this.authApiRepository}) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onFormSubmitted);
    on<FetchSessionStatusEvent>(_onFetchSessionStatus);
    on<StartTerminalSessionEvent>(_onStartTerminalSession);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    LoginApi event,
    Emitter<LoginState> emit,
  ) async {
    String deviceToken =
        await NotificationServices.getToken() ?? "d7d0a4a2bd889fdf77c6a1b";
    final data = {
      'email': state.email,
    //  'pin': state.password,
      'pin': state.password,
      'language': isEnglish?"en":"ar",
      'device_token': deviceToken,
      'device_type': "kds",
    };

    emit(state.copyWith(
      postApiStatus: LoginEnum.loading,
    ));

    await authApiRepository.loginApi(data).then((res) async {
   //   if (res.success == true) {

        await SessionController().saveUserInPreference(res);
        await SessionController().getUserFromPreference();
        emit(state.copyWith(
          postApiStatus: LoginEnum.success,
         // message: res.message ?? "Login Success",
      //    response: res, // ✅ save full API response here
        ));
     /* } else {
        emit(state.copyWith(
          postApiStatus: PostApiStatus.error,
          message: res.message ?? "Login Failed",
          response: null, // reset on error
        ));
      }**/
    }).onError((error, stackTrace) {
      emit(state.copyWith(
        postApiStatus: LoginEnum.error,
        message: "$error",
        response: null,
      ));
    });
  }  Future<void> _onFetchSessionStatus(
    FetchSessionStatusEvent event,
    Emitter<LoginState> emit,
  ) async {

    emit(state.copyWith(
      sessionStatusEnum: SessionStatusEnum.loading,
    ));

    await authApiRepository.fetchSessionStatus().then((res) async {

        emit(state.copyWith(sessionStatusResponse: res,
          sessionStatusEnum: SessionStatusEnum.success,

        ));

    }).onError((error, stackTrace) {
      emit(state.copyWith(
        sessionStatusEnum: SessionStatusEnum.error,
        message: "$error",
        response: null,
      ));
    });
  }

  Future<void> _onStartTerminalSession(
    StartTerminalSessionEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(startSessionStatus: StartSessionStatus.loading));
    try {
      final body = {
        's_label': 'APP-${AppUtils.getFormattedDate()}',
        's_user_id': SessionController.user.sno,
        's_counter_id': event.counterId,
        'device_id': SessionController.user.deviceId,
      };
      await authApiRepository.createPosSession(body).then((res) async {

        emit(state.copyWith(//sessionStatusResponse: res,
          startSessionStatus: StartSessionStatus.success,

        ));

      }).onError((error, stackTrace) {
        emit(state.copyWith(
          startSessionStatus: StartSessionStatus.error,
          message: "$error",
          response: null,
        ));
      });

    //  await NetworkServices().getPostApi(AppUrl.createPosSession, body, isToken: true);
   //   emit(state.copyWith(startSessionStatus: StartSessionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        startSessionStatus: StartSessionStatus.error,
        startSessionMessage: '$e',
      ));
    }
  }
}
