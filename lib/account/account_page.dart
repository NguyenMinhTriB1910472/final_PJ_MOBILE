import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grab_app_clone_2/base/custom_loader.dart';
import 'package:grab_app_clone_2/controllers/auth_controller.dart';
import 'package:grab_app_clone_2/controllers/cart_controller.dart';
// import 'package:grab_app_clone_2/controllers/user_controller.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import 'package:grab_app_clone_2/widgets/account_widget.dart';
import 'package:grab_app_clone_2/widgets/app_icon.dart';
import 'package:grab_app_clone_2/widgets/big_text.dart';
import '../account/account_page.dart';
import '../controllers/user_controller.dart';
import '../ultis/dimensions.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';
import '../models/user_repo.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn&&Get.find<UserController>().userModel==null) {
      Get.find<UserController>().getUserInfo();
      print("user has logged in!");
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          title: BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (!userController.isLoading
                    ? Container(
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: Dimension.height20),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 80,
                                backgroundImage:
                                    AssetImage("assets/image/team.gif"),
                              ),
                              SizedBox(
                                height: Dimension.height20,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.person,
                                            backgroundColor: AppColor.mainColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimension.height10 * 5 / 2,
                                            size: Dimension.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: '${userController.userModel?.name}',
                                            // text: '${userController.userModel?.name}',
                                            size: Dimension.font20
                                          )),
                                      SizedBox(
                                        height: Dimension.height30,
                                      ),
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.phone,
                                            backgroundColor:
                                                AppColor.yellowColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimension.height10 * 5 / 2,
                                            size: Dimension.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: "${userController.userModel?.phone}",
                                            //text: "0943221490",
                                            size: Dimension.font20,
                                          )),
                                      SizedBox(
                                        height: Dimension.height30,
                                      ),
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.email,
                                            backgroundColor:
                                                AppColor.yellowColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimension.height10 * 5 / 2,
                                            size: Dimension.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: '${userController.userModel?.email}',
                                            size: Dimension.font20,
                                          )),
                                      SizedBox(
                                        height: Dimension.height30,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Get.offNamed(RouteHelper.getAddressPage());
                                        },
                                        child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              backgroundColor:
                                                  AppColor.yellowColor,
                                              iconColor: Colors.white,
                                              iconSize:
                                                  Dimension.height10 * 5 / 2,
                                              size: Dimension.height10 * 5,
                                            ),
                                            bigText: BigText(
                                              text: "Fill your address",
                                              size: Dimension.font20,
                                            )),
                                      ),
                                      SizedBox(
                                        height: Dimension.height30,
                                      ),
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.message,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimension.height10 * 5 / 2,
                                            size: Dimension.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: "Message",
                                            size: Dimension.font20,
                                          )),
                                      SizedBox(
                                        height: Dimension.height30,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (Get.find<AuthController>().userLoggedIn()) {
                                            Get.find<AuthController>().clearSharedData();
                                            Get.find<CartController>().clearCartHistory();
                                            Get.find<CartController>().clear();
                                            Get.find<UserController>().clearData();
                                            Get.offNamed(
                                                RouteHelper.getSignInPage());
                                          } else {
                                            print("you logged out");
                                          }
                                        },
                                        child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.logout,
                                              backgroundColor: Colors.redAccent,
                                              iconColor: Colors.white,
                                              iconSize:
                                                  Dimension.height10 * 5 / 2,
                                              size: Dimension.height10 * 5,
                                            ),
                                            bigText: BigText(
                                              text: "Logout",
                                              size: Dimension.font20,
                                            )),
                                      ),
                                      SizedBox(
                                        height: Dimension.height30,
                                      ),
                                      AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.favorite,
                                            backgroundColor: Colors.pinkAccent,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimension.height10 * 5 / 2,
                                            size: Dimension.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: "My favorite",
                                            size: Dimension.font20,
                                          )),
                                      SizedBox(
                                        height: Dimension.height30,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child:
                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: Dimension.height20*15,
                              margin: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimension.radius20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/image/foodanimation2.gif")
                                  )
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(RouteHelper.getSignInPage());
                              },
                              child: Container(
                                width: Dimension.width45*4,
                                height: Dimension.height20*4,
                                margin: EdgeInsets.only(left: Dimension.width20,right: Dimension.width20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimension.radius20),
                                    color: AppColor.iconColor1,
                                ),
                                child: Center(
                                  child: BigText(text: "Sign In",color: Colors.white,
                                    size: Dimension.font20*1.5,),
                                ),
                              ),
                            )
                          ],
                        )),
                  );
          },
        ));
  }
}

// class AccountPage extends StatelessWidget {
//   const AccountPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
//     if (_userLoggedIn && Get.find<UserController>()
//         .userModel == null) {
//       Get.find<UserController>().getUserInfo();
//       // Get.find<LocationController>().getAddressList();
//     }
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.mainColor,
//         title: BigText(text: "Profile", size: 40, color: Colors.white,),
//       ),
//       body: GetBuilder<UserController>(builder: (userController) {
//         return _userLoggedIn
//             ? (userController.isLoading ? CustomLoader() : Container(
//           width: double.maxFinite,
//           margin: EdgeInsets.only(top: Dimension.height20),
//           child: Column(
//             children: [
//               //profile icon
//               AppIcon(
//                 icon: Icons.person,
//                 backgroundColor: AppColor.mainColor,
//                 iconColor: Colors.white,
//                 iconSize: Dimension.iconSize16 * 5,
//                 size: Dimension.height15 * 10,),
//               Expanded(child: SingleChildScrollView(child: Column(
//                 children: [
//                   //name
//                   SizedBox(height: Dimension.height20,),
//                   AccountWidget(appIcon: AppIcon(
//                     icon: Icons.person,
//                     backgroundColor: AppColor.mainColor,
//                     iconColor: Colors.white,
//                     iconSize: Dimension.height10 * 5 / 2,
//                     size: Dimension.height10 * 5,),
//                       bigText: BigText(
//                         text: '${userController.userModel?.name}',
//                       size: Dimension.font20,)
//                   ),
//                   //phone
//                   SizedBox(height: Dimension.height20,),
//                   AccountWidget(appIcon: AppIcon(
//                     icon: Icons.phone,
//                     backgroundColor: AppColor.yellowColor,
//                     iconColor: Colors.white,
//                     iconSize: Dimension.height10 * 5 / 2,
//                     size: Dimension.height10 * 5,),
//                       bigText: BigText(
//                         //text: '${userController.userModel?.phone}',)
//                         text:"111",)
//                   ),
//                   //email
//                   SizedBox(height: Dimension.height20,),
//                   AccountWidget(appIcon: AppIcon(
//                     icon: Icons.email,
//                     backgroundColor: AppColor.yellowColor,
//                     iconColor: Colors.white,
//                     iconSize: Dimension.height10 * 5 / 2,
//                     size: Dimension.height10 * 5,),
//                       bigText: BigText(
//                         text: '${userController.userModel?.email}',)
//                   ),
//                   //address
//                   SizedBox(height: Dimension.height20,),
//                   // GetBuilder<LocationController>(builder: (locationController) {
//                   //   return GestureDetector(
//                   //     onTap: () {
//                   //       Get.offNamed(RouteHelper.getAddressPage());
//                   //     },
//                   //     child: AccountWidget(appIcon: AppIcon(
//                   //       icon: Icons.location_on,
//                   //       backgroundColor: AppColor.yellowColor,
//                   //       iconColor: Colors.white,
//                   //       iconSize: Dimension.height10 * 5 / 2,
//                   //       size: Dimension.height10 * 5,),
//                   //         bigText: BigText(text:
//                   //         locationController.addressList.isEmpty
//                   //             ? "Fill in your address"
//                   //             : "Your address",)
//                   //     ),
//                   //   );
//                   // }),
//                   //message
//                   SizedBox(height: Dimension.height20,),
//                   AccountWidget(appIcon: AppIcon(
//                     icon: Icons.message_outlined,
//                     backgroundColor: Colors.redAccent,
//                     iconColor: Colors.white,
//                     iconSize: Dimension.height10 * 5 / 2,
//                     size: Dimension.height10 * 5,),
//                       bigText: BigText(text: "Messages",)
//                   ),
//                   SizedBox(height: Dimension.height20,),
//                   GestureDetector(
//                     onTap: () {
//                       if (Get.find<AuthController>().userLoggedIn()) {
//                         Get.find<AuthController>().clearSharedData();
//                         Get.find<CartController>().clear();
//                         Get.find<CartController>().clearCartHistory();
//                         Get.toNamed(RouteHelper.getSignInPage());
//                       }
//                     },
//                     child: AccountWidget(
//                         appIcon: AppIcon(
//                           icon: Icons.logout,
//                           backgroundColor: Colors.redAccent,
//                           iconColor: Colors.white,
//                           iconSize: Dimension.height10 * 5 / 2,
//                           size: Dimension.height10 * 5,),
//                         bigText: BigText(text: "Logout",)
//                     ),
//                   )
//                 ],
//               ),
//               ),
//               )
//             ],
//           ),
//         )) : Container(child: Center(child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: double.maxFinite,
//               height: Dimension.width20 * 8,
//               margin: EdgeInsets.symmetric(horizontal: Dimension.width20),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimension.radius20),
//                   image: DecorationImage(
//                     image: AssetImage("assets/image/team.gif"),
//                     fit: BoxFit.cover,
//                   )
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Get.toNamed(RouteHelper.getSignInPage());
//               },
//               child: Container(
//                 width: double.maxFinite,
//                 height: Dimension.width20 * 5,
//                 margin: EdgeInsets.symmetric(horizontal: Dimension.width20),
//                 decoration: BoxDecoration(color: AppColor.mainColor,
//                   borderRadius: BorderRadius.circular(Dimension.radius20),
//                 ),
//                 child: Center(child: BigText(text: "Sign in",
//                   color: Colors.white, size: Dimension.font26,),),
//               ),
//             ),
//           ],
//         ),),);
//       },),
//     );
//   }
// }





