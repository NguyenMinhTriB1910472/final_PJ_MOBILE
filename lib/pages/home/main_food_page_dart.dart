import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grab_app_clone_2/pages/search/search_page.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import 'package:grab_app_clone_2/ultis/dimensions.dart';
import 'package:grab_app_clone_2/widgets/big_text.dart';
import 'package:grab_app_clone_2/widgets/small_text.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommend_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _loadResource,
        child: Column(
      children: [
        Container(
          child: Container(
              margin: EdgeInsets.only(
                  top: Dimension.height45, bottom: Dimension.height15),
              padding: EdgeInsets.only(
                  left: Dimension.width20, right: Dimension.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Cần Thơ", color: AppColor.mainColor,size: Dimension.font26,),
                      Row(
                        children: [
                          SmallText(text: "Ninh Kiều", color: Colors.black54),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimension.width45,
                      height: Dimension.height45,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimension.radius15),
                        color: AppColor.mainColor,
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getSearchItem());
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimension.iconSize24,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
        const Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
      ],
    )
    );
  }
}
