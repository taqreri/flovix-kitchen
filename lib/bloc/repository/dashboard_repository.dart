import 'package:flovix_kitchen/utils/app_url.dart';
import 'package:flovix_kitchen/utils/network/network_services.dart';

class DashboardRepository {
  DashboardRepository();

  final NetworkServices _apiServices = NetworkServices();

  Future<bool?> logoutEvent(dynamic data) async {
    final response = await _apiServices.getPostApi(
      AppUrl.logoutEndpoint,
      data,
    );

    if (response is Map && response['success'] == true) {
      return true;
    }
    return false;
  }
}
