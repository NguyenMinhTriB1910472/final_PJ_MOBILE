import 'package:get/get.dart';
import 'package:grab_app_clone_2/controllers/auth_controller.dart';
import 'package:grab_app_clone_2/controllers/cart_controller.dart';
import 'package:grab_app_clone_2/controllers/location_controller.dart';
import 'package:grab_app_clone_2/controllers/popular_product_controller.dart';
import 'package:grab_app_clone_2/controllers/recommend_product_controller.dart';
import 'package:grab_app_clone_2/controllers/user_controller.dart';
import 'package:grab_app_clone_2/data/api/api_client.dart';
import 'package:grab_app_clone_2/data/repository/auth_repo.dart';
import 'package:grab_app_clone_2/data/repository/cart_repo.dart';
import 'package:grab_app_clone_2/data/repository/location_repo.dart';
import 'package:grab_app_clone_2/data/repository/popular_product_repo.dart';
import 'package:grab_app_clone_2/data/repository/recommended_product_repo.dart';
import 'package:grab_app_clone_2/models/user_repo.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async {
  SharedPreferences.setMockInitialValues({});
  final sharedPreferences =await SharedPreferences.getInstance();

  Get.lazyPut(()=>sharedPreferences);
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppContrants.BASE_URL, sharedPreferences: sharedPreferences));
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(),sharedPreferences:Get.find()));
  Get.lazyPut(()=>UserRepo(apiClient: Get.find()));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo : Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));
}