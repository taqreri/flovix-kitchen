import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginApi extends LoginEvent {}

class FetchSessionStatusEvent extends LoginEvent {
  const FetchSessionStatusEvent();

  @override
  List<Object> get props => [];
}

class StartTerminalSessionEvent extends LoginEvent {
  const StartTerminalSessionEvent({required this.counterId});
  final int counterId;
  @override
  List<Object> get props => [counterId];
}
