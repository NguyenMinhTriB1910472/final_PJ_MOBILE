import 'package:get/get.dart';
//import 'package:grab_app_clone_2/models/response_model.dart';
import 'package:grab_app_clone_2/models/signup_body_model.dart';
import 'package:grab_app_clone_2/data/repository/auth_repo.dart';
import 'package:grab_app_clone_2/models/user_model.dart';
import 'package:grab_app_clone_2/models/user_repo.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';

import '../models/response_model.dart';
import '../models/user_repo.dart';
// class UserController extends GetxController implements GetxService{
//   final UserRepo userRepo;
//   UserController({
//     required this.userRepo
//   });
//   bool _isLoading =false;
//   UserModel? _userModel;
//   UserModel? get userModel => _userModel;
//   bool get isLoading => _isLoading;
//   Future<ResponseModel> getUserInfo() async{
//     _isLoading=true;
//     update();
//     Response response =await userRepo.getUserInfo();
//     late ResponseModel responseModel;
//     if(response.statusCode==200){
//       print("ahaihaiaia");
//       _userModel =UserModel.fromJson(response.body);
//       responseModel =ResponseModel(true, "successfully");
//     }else{
//       responseModel =ResponseModel(false, response.statusText!);
//     }
//     _isLoading=false;
//     update();
//     return responseModel;
//   }
// }
class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  UserController({required this.userRepo});

  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print(response.body.toString());
    if(response.statusCode == 200){
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, 'successfully');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print(response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  void clearData(){
    _userModel = null;
  }
}