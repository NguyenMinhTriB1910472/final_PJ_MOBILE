import 'package:get/get.dart';
import 'package:grab_app_clone_2/auth/sign_in_page.dart';
import 'package:grab_app_clone_2/pages/address/pick_address_map.dart';
import 'package:grab_app_clone_2/pages/cart/cart_page.dart';
import 'package:grab_app_clone_2/pages/food/popular_food_detail.dart';
import 'package:grab_app_clone_2/pages/home/home_page.dart';
import 'package:grab_app_clone_2/pages/search/search_page.dart';
import 'package:grab_app_clone_2/pages/splash_page/splash_page.dart';

import '../pages/address/add_address_page.dart';
import '../pages/food/recommended_food_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage="/splash-page";
  static const String signIn="/sign-in";
  static const String search="/search";

  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";

  static String getInitial() => '$initial';
  static String getSplashPage()=>'$splashPage';
  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId,String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getSignInPage()=>'$signIn';
  static String getCartPage() => '$cartPage';
  static String getAddressPage()=>'$addAddress';
  static String getSearchItem()=>'$search';
  static String getPickAddressPage()=>'$pickAddressMap';
  static List<GetPage> routes = [
    GetPage(name: pickAddressMap, page: (){
      PickAddress _pickAddress=Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: signIn, page: () {
      return SignInPage();
    },transition: Transition.fade),

    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page=Get.parameters['page'];
          return PopularFoodDetail1(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page=Get.parameters['page'];
          return RecommenedFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn
    ),
    GetPage(name: addAddress, page:(){
      return AddAddressPage();
    }),
    GetPage(name: search, page: (){
      return const SearchScreen();
    },transition: Transition.fadeIn),

  ];
}
//GetPage(name: popularFood,page: ()=>PopularFoodDetail1())
