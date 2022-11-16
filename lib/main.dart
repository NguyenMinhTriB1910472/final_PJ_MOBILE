import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_app_clone_2/auth/sign_in_page.dart';
import 'package:grab_app_clone_2/auth/sign_up_page.dart';
import 'package:grab_app_clone_2/controllers/cart_controller.dart';
import 'package:grab_app_clone_2/controllers/popular_product_controller.dart';
import 'package:grab_app_clone_2/pages/splash_page/splash_page.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'controllers/recommend_product_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  Get.find<CartController>().getCartData();
  return  GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: SignInPage(),
          // home: MainFoodPage(),
          initialRoute: RouteHelper.getSplashPage(),
          // home: SplashScreen(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}

