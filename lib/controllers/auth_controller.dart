import 'package:get/get.dart';
import 'package:grab_app_clone_2/models/response_model.dart';
import 'package:grab_app_clone_2/models/signup_body_model.dart';
import 'package:grab_app_clone_2/data/repository/auth_repo.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';
class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo
});
  bool _isLoading =false;
  bool get isLoading => _isLoading;
  Future<ResponseModel> registraion(SignUpBody  signUpBody) async{
    _isLoading=true;
    update();
    Response response =await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel =ResponseModel(true, response.body["token"]);
    }else{
      responseModel =ResponseModel(false, response.statusText!);
    }
    _isLoading=false;
    update();
    return responseModel;
  }
  Future<ResponseModel> login(String phone,String password) async{
    _isLoading=true;
    update();
    Response response =await authRepo.login(phone,password);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      print("My token is "+ response.body["token"]);

      responseModel =ResponseModel(true, response.body["token"]);
    }else{
      responseModel =ResponseModel(false, response.statusText!);
    }
    _isLoading=false;
    update();
    return responseModel;
  }
  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }
  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
  void saveUserNumberAndPassWord(String number,String password){
    authRepo.saveUserNumberAndPassWord(number, password);
  }
}