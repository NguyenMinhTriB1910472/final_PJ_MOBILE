import 'package:get/get.dart';
import 'package:grab_app_clone_2/data/api/api_client.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<Response> getUserInfo() async{
    return apiClient.getData(AppContrants.USER_INFO_URI);
  }
}