import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_app_clone_2/controllers/cart_controller.dart';
import 'package:grab_app_clone_2/controllers/popular_product_controller.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import 'package:grab_app_clone_2/widgets/app_column2.dart';
import '../../ultis/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class PopularFoodDetail1 extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail1({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    String s = product.description!;
    // print("page is id "+pageId.toString());
    // print("produt name is "+product.name.toString());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page=='cartpage'){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: const AppIcon(icon: Icons.clear),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems>=1){
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_checkout_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap:(){
                                      Get.toNamed(RouteHelper.getCartPage());
                                    },
                                    child: const AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColor.mainColor,
                                    ),
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimension.radius20),
                            topRight: Radius.circular(Dimension.radius20))),
                    child: Center(
                      child: BigText(
                        size: Dimension.font26,
                        text: product.name!,
                      ),
                    ),
                  )),
              backgroundColor: AppColor.yellowColor,
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppContrants.BASE_URL +
                      AppContrants.UPLOAD_URL +
                      product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimension.width10,
                        right: Dimension.width10,
                        bottom: Dimension.width20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Dimension.height10,
                        ),
                        SizedBox(
                          height: Dimension.height10,
                        ),
                        const AppColumn2(text: "")
                      ],
                    ),
                  ),
                  BigText(
                    text: "Introduce",
                    size: Dimension.font20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimension.width20, right: Dimension.width20),

                    child: ExpandableText(
                      s,
                      expandText: 'show more',
                      collapseText: 'show less',
                      maxLines: 1,
                      linkColor: Colors.blue,
                    ),

                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimension.width20 * 2.5,
                      right: Dimension.width20 * 2.5,
                      top: Dimension.height10,
                      bottom: Dimension.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: AppIcon(
                            iconSize: Dimension.iconSize24,
                            iconColor: Colors.white,
                            backgroundColor: AppColor.mainColor,
                            icon: Icons.remove),
                      ),
                      BigText(
                        text:"\$ ${product.price!} X ${popularProduct.quantity}",
                        color: AppColor.mainBlackColor,
                        size: Dimension.font26,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: AppIcon(
                            iconSize: Dimension.iconSize16,
                            icon: Icons.add,
                            iconColor: Colors.white,
                            backgroundColor: AppColor.mainColor),
                      )
                    ],
                  ),
                ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimension.height20,
                            bottom: Dimension.height20,
                            left: Dimension.height20,
                            right: Dimension.height20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            color: Colors.white),
                        child: const Icon(
                          Icons.favorite,
                          color: AppColor.mainColor,
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
                            popularProduct.addItem(product);
                          },
                          child: BigText(
                            text: "\$ ${product.price!} | Add to cart",
                            color: Colors.white,
                            size: Dimension.font20,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}

