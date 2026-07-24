import 'package:equatable/equatable.dart';
import 'package:flovix_kitchen/utils/enums.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.logoutEnum = LogoutEnum.initial,
    this.message = '',
  });

  final LogoutEnum logoutEnum;
  final String message;

  DashboardState copyWith({
    LogoutEnum? logoutEnum,
    String? message,
  }) {
    return DashboardState(
      logoutEnum: logoutEnum ?? this.logoutEnum,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [logoutEnum, message];
}
