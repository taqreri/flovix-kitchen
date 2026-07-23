import 'package:equatable/equatable.dart';
import 'package:flovix_kitchen/config/app_env.dart' show AppEnv;
import 'package:flovix_kitchen/model/session_status_model.dart';
import 'package:flovix_kitchen/model/user_model/user_model_new/User_model_new.dart';
import 'package:flovix_kitchen/utils/enums.dart' show LoginEnum, StartSessionStatus, SessionStatusEnum;


class LoginState extends Equatable {
  const LoginState({
   //this.email = '',
 //  this.email = AppEnv.flavor=="production"?'':"imshafi.pro@gmail.com",
   this.email = AppEnv.flavor=="production"?'':"dsjswt@gmail.com",
    this.password = AppEnv.flavor=="production"?'':'32732',
    //this.password = AppEnv.flavor=="production"?'':'89828',
   // this.password = '',
    this.loginEnum = LoginEnum.initial,
    this.message = '',
    this.response,
    this.sessionStatusResponse,

    this.sessionStatusEnum = SessionStatusEnum.initial,
    this.sessionStatusMessage = '',
    this.startSessionStatus = StartSessionStatus.initial,
    this.startSessionMessage = ''
  });

  final String email;
  final String password;
  final String message;
  final LoginEnum loginEnum;
  final UserModelNew? response;
  final SessionStatusResponse? sessionStatusResponse;
  final SessionStatusEnum sessionStatusEnum;
  final String sessionStatusMessage;
  final StartSessionStatus startSessionStatus;
  final String startSessionMessage;

  LoginState copyWith({
    String? email,
    String? password,
    String? message,
    LoginEnum? postApiStatus,
    UserModelNew? response,
    SessionStatusResponse? sessionStatusResponse,
    SessionStatusEnum? sessionStatusEnum,
    String? sessionStatusMessage,
    StartSessionStatus? startSessionStatus,
    String? startSessionMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      loginEnum: postApiStatus ?? this.loginEnum,
      response: response ?? this.response,
      sessionStatusResponse: sessionStatusResponse ?? this.sessionStatusResponse,
      sessionStatusEnum: sessionStatusEnum ?? this.sessionStatusEnum,
      sessionStatusMessage: sessionStatusMessage ?? this.sessionStatusMessage,
      startSessionStatus: startSessionStatus ?? this.startSessionStatus,
      startSessionMessage: startSessionMessage ?? this.startSessionMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        loginEnum,
        message,
        response,
        sessionStatusResponse,
        sessionStatusEnum,
        sessionStatusMessage,
        startSessionStatus,
        startSessionMessage,
      ];
}
