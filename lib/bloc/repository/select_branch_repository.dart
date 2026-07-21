import 'package:flovix_kitchen/model/branches_model/branches_model.dart';
import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flovix_kitchen/utils/app_url.dart';
import 'package:flovix_kitchen/utils/network/network_services.dart';


class SelectBranchRepository {
  SelectBranchRepository();

  final NetworkServices _apiServices = NetworkServices();

  Future<BranchesModel> getCompanyBranches() async {
    // debugPrint(data.toString());
    String token = SessionController.user.token!;
    dynamic response = await _apiServices.getGetApi(
      AppUrl.selectBranchUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Passing Bearer token in header
      },
    );
    
    return BranchesModel.fromJson(response);
  }
}
