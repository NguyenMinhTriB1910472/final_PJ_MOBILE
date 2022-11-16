import 'package:get/get.dart';
import 'package:grab_app_clone_2/data/api/api_client.dart';
import 'package:grab_app_clone_2/models/signup_body_model.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppContrants.REGISTRATION_URI, signUpBody.toJson());
  }
  Future<Response> login(String phone,String password) async {
    return await apiClient.postData(
        AppContrants.LOGIN_URI, {"phone":phone,"password":password});
  }
  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppContrants.TOKEN);
  }
  Future<String> getUserToken() async{
    return await sharedPreferences.getString(AppContrants.TOKEN)??"";
  }
  Future<bool> saveUserToken(String token) async {
    apiClient.token=token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppContrants.TOKEN, token);
  }
  Future<void> saveUserNumberAndPassWord(String number,String password) async{
    try{
      await sharedPreferences.setString(AppContrants.PHONE, number);
      await sharedPreferences.setString(AppContrants.PASSWORD, number);
    }catch(e){
      throw e;
    }
  }
  bool clearSharedData(){
    sharedPreferences.remove(AppContrants.TOKEN);
    sharedPreferences.remove(AppContrants.PASSWORD);
    sharedPreferences.remove(AppContrants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }

}
