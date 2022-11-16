import 'package:flutter/material.dart';

import '../../ultis/colors.dart';
import '../../ultis/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class BasicSliverAppBar extends StatelessWidget {
  const BasicSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                toolbarHeight: 70,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    AppIcon(icon: Icons.clear),
                    AppIcon(icon: Icons.shopping_cart_checkout_outlined)
                  ],
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: Dimension.width20, right: Dimension.width20),
                      color: AppColor.mainBlackColor,
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: Center(
                          child: BigText(
                        text: 'Chinese Food',
                        size: Dimension.font20,
                      )),
                    )))
          ],
        ),
      );
}
