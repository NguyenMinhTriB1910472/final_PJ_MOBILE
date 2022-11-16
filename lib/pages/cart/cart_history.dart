import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_app_clone_2/base/no_data_page.dart';
import 'package:grab_app_clone_2/controllers/cart_controller.dart';
import 'package:grab_app_clone_2/models/Cart_model.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import 'package:grab_app_clone_2/widgets/app_icon.dart';
import 'package:grab_app_clone_2/widgets/big_text.dart';
import 'package:grab_app_clone_2/widgets/small_text.dart';
import 'package:intl/intl.dart';

import '../../ultis/dimensions.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    print(cartItemsPerOrder);
    List<int> cartOrderPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPreOrder = cartOrderPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index){
      var outPutDate=DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(
            getCartHistoryList[listCounter]
                .time!);
        var inputDate =
        DateTime.parse(parseDate.toString());
        var outPutFormat =
        DateFormat("MM/dd/yyyy hh:mm a");
        var outPutDate =
        outPutFormat.format(inputDate);

      }
      return BigText(
          text: outPutDate,
          size: Dimension.font20);
    }
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: Dimension.height10 * 10,
          color: AppColor.mainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimension.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "Cart History",
                size: Dimension.font20,
                color: Colors.white,
              ),
              AppIcon(
                icon: Icons.shopping_cart_checkout_outlined,
                iconColor: AppColor.mainColor,
                backgroundColor: Colors.white,
              )
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getCartHistoryList().length > 0
              ? Expanded(
                  child: Container(
                  height: 500,
                  margin: EdgeInsets.only(
                      top: Dimension.height20,
                      left: Dimension.width20,
                      right: Dimension.width20),
                  child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          //itemsPreOrder.length
                          for (int i = 0; i < itemsPreOrder.length; i++)
                            Container(
                              height: Dimension.height30 * 4,
                              margin:
                                  EdgeInsets.only(bottom: Dimension.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  SizedBox(
                                    height: Dimension.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPreOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    height: Dimension.height20 *
                                                        3.5,
                                                    width:
                                                        Dimension.width20 * 3.5,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimension.width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimension
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppContrants
                                                                    .BASE_URL +
                                                                AppContrants
                                                                    .UPLOAD_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!))),
                                                  )
                                                : Container();
                                          })),
                                      Container(
                                        height: Dimension.height20 * 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SmallText(text: "total"),
                                            BigText(
                                              text:
                                                  itemsPreOrder[i].toString() +
                                                      " Items",
                                              color: AppColor.titleColor,
                                              size: Dimension.font20,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimension.width10,
                                                      vertical:
                                                          Dimension.height10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimension
                                                                  .radius15 /
                                                              2),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColor
                                                              .mainColor)),
                                                  child: SmallText(
                                                    text: "one more",
                                                    color: AppColor.mainColor,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                        ],
                      )),
                ))
              : SizedBox(
            height: MediaQuery.of(context).size.height/1.5,
                  child: const Center(
                    child: NoDataPage(
                    text: "You didn't anything so far!",
                    imgPath: "assets/image/empty1.png",
                ),
                  ));
        })
      ],
    ));
  }
}
