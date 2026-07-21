
import 'package:flovix_kitchen/model/user_model/user_model_new/User_model_new.dart';
import 'package:flovix_kitchen/utils/app_url.dart';
import 'package:flovix_kitchen/utils/network/network_services.dart' show NetworkServices;

import '../../model/session_status_model.dart' show SessionStatusResponse, NewSessionModalData, Counter;

class LoginRepository {
  LoginRepository();

  final NetworkServices _apiServices = NetworkServices();

  Future<UserModelNew> loginApi(dynamic data) async {
    // debugPrint(data.toString());
    dynamic response = await _apiServices.getPostApi(AppUrl.deviceLogin, data,isToken: false,isLogin: true);
    
    return UserModelNew.fromJson(response["data"]);
  }

  /// Fetches session status (active session + counter). Returns null if no session or API error.
    Future<SessionStatusResponse?> fetchSessionStatus() async {
    try {
      final response = await _apiServices.getGetApi(
        AppUrl.sessionStatus,
        isToken: true,
      );
      if (response == null || response is! Map) return null;
      final data = response['data'] ?? response;
      if (data is! Map<String, dynamic>) return null;
      final activeSession = data['active_session'];
      final counter = data['counter'];
      if (activeSession is List && activeSession.isEmpty &&
          counter is List && counter.isEmpty) {
        return null;
      }
      return SessionStatusResponse.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  /// Fetches data for new session modal (session id, user, counter list). Returns null on error.
  Future<NewSessionModalData?> fetchNewSessionModal() async {
    try {
      final response = await _apiServices.getGetApi(
        AppUrl.newSessionModal,
        isToken: true,
      );
      if (response == null || response is! Map) return null;
      final data = response['data'] ?? response;
      if (data is! Map<String, dynamic>) return null;
      final posSession = data['pos_session'];
      final user = data['user'];
      final counterList = data['counter'];
      if (counterList is! List) return null;
      final counters = counterList
          .whereType<Map<String, dynamic>>()
          .map((e) => Counter.fromJsonMinimal(e))
          .toList();
      return NewSessionModalData(
        sessionId: posSession?.toString() ?? '',
        user: user?.toString() ?? '',
        counters: counters,
      );
    } catch (_) {
      return null;
    }
  }

  /// Creates a POS session (start terminal session). Throws on API error.
  Future<void> createPosSession(Map<String, dynamic> body) async {
    await _apiServices.getPostApi(
      AppUrl.createPosSession,
      body,
      isToken: true,
    );
    dynamic response = await _apiServices.getPostApi(AppUrl.createPosSession, body,isToken: true,isLogin: false);

    

  }
}
