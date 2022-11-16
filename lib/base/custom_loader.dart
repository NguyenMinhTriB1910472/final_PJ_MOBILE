import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_app_clone_2/controllers/auth_controller.dart';
import 'package:grab_app_clone_2/ultis/dimensions.dart';
import '../ultis/colors.dart';
import 'package:get/get.dart';
class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("I am printing loading state"+ Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        height: Dimension.height20*5,
        width: Dimension.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.height20*5/2),
          color: AppColor.mainColor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
