import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_app_clone_2/base/no_data_page.dart';
import 'package:grab_app_clone_2/controllers/cart_controller.dart';
import 'package:grab_app_clone_2/controllers/location_controller.dart';
import 'package:grab_app_clone_2/controllers/popular_product_controller.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import 'package:grab_app_clone_2/ultis/dimensions.dart';
import 'package:grab_app_clone_2/widgets/app_icon.dart';
import 'package:grab_app_clone_2/widgets/big_text.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/recommend_product_controller.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: Dimension.width20,
                right: Dimension.width20,
                top: Dimension.height20 * 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
                    SizedBox(
                      width: Dimension.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColor.mainColor,
                        iconSize: Dimension.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      iconSize: Dimension.iconSize24,
                    )
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimension.height20 * 5,
                      left: Dimension.width20,
                      right: Dimension.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimension.height15),
                        // color: Colors.red,
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: GetBuilder<CartController>(
                              builder: (cartController) {
                            var cartList = cartController.getItems;
                            return ListView.builder(
                                itemCount: cartList.length,
                                itemBuilder: (_, index) {
                                  return SizedBox(
                                    height: Dimension.height20 * 5,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      "cartpage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(
                                                      cartList[index].product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History Product!",
                                                    "Product review is not available!",
                                                    backgroundColor:
                                                        AppColor.mainColor,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimension.height20 * 5,
                                            height: Dimension.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimension.height10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppContrants.BASE_URL +
                                                          AppContrants
                                                              .UPLOAD_URL +
                                                          cartController
                                                              .getItems[index]
                                                              .img!)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimension.radius20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimension.width10,
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          height: Dimension.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                size: Dimension.font20,
                                                color: AppColor.mainBlackColor,
                                              ),
                                              SmallText(
                                                text: "Spicy",
                                                color: AppColor.mainBlackColor,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index].price
                                                        .toString(),
                                                    color: Colors.redAccent,
                                                    size: Dimension.font20,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimension.height10,
                                                        bottom:
                                                            Dimension.height10,
                                                        right:
                                                            Dimension.height10,
                                                        left:
                                                            Dimension.height10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimension
                                                                    .radius20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: const Icon(
                                                              Icons.remove,
                                                              color: AppColor
                                                                  .sighColor),
                                                        ),
                                                        SizedBox(
                                                          width: Dimension
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                          text: cartList[index]
                                                              .quantity
                                                              .toString(),
                                                          size:
                                                              Dimension.font20,
                                                        ),
                                                        SizedBox(
                                                          width: Dimension
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: const Icon(
                                                              Icons.add,
                                                              color: AppColor
                                                                  .sighColor),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  );
                                });
                          }),
                        ),
                      ),
                    )
                  : NoDataPage(text: "Your Cart Is Empty!");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimension.bottomHeightBar,
                  padding: EdgeInsets.only(
                      top: Dimension.height30,
                      bottom: Dimension.height30,
                      left: Dimension.height30,
                      right: Dimension.height30),
                  decoration: BoxDecoration(
                      color: AppColor.buttonBackgroundColors,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimension.radius20 * 2),
                          topRight: Radius.circular(Dimension.radius20 * 2))),
                  child:cartController.getItems.length>0? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimension.height10,
                            bottom: Dimension.height10,
                            right: Dimension.height10,
                            left: Dimension.height10),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimension.radius20),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Dimension.width10 / 2,
                            ),
                            BigText(
                              text:
                              "\$ " + cartController.totalAmount.toString(),
                              size: Dimension.font20,
                            ),
                            SizedBox(
                              width: Dimension.width10 / 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: Dimension.height20,
                            right: Dimension.height20,
                            top: Dimension.height20,
                            bottom: Dimension.height20),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimension.radius20),
                          color: AppColor.mainColor,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if(Get.find<AuthController>().userLoggedIn()){
                              print("cailolque");
                              if(Get.find<LocationController>().addressList.isEmpty){
                                Get.toNamed(RouteHelper.getAddressPage());
                              }else{
                                Get.offNamed(RouteHelper.getInitial());
                              }
                              cartController.addToHistory();
                            }else{
                              Get.toNamed(RouteHelper.getSignInPage());
                            }
                            //popularProduct.addItem(product);
                          },
                          child: BigText(
                            text: "Check Out",
                            color: Colors.white,
                            size: Dimension.font20,
                          ),
                        ),
                      )
                    ],
                  ):Container()
                )
              ],
            );
          },
        ));
  }
}
