import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import '../ultis/dimensions.dart';
class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData iconData;
  bool isObscure;
  AppTextField({Key? key,
  required this.textEditingController,
  required this.hintText,
  required this.iconData,
  this.isObscure=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimension.height20,right: Dimension.height20),
      //box style
      decoration: BoxDecoration(
          color: Colors.white,
          // bo tròn các gốc
          borderRadius: BorderRadius.circular(Dimension.radius15),
          boxShadow: [
            BoxShadow(
              //tạo bóng
                blurRadius:3,
                spreadRadius: 1,
                offset: Offset(1,1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: isObscure?true:false,
          controller: textEditingController,
          decoration: InputDecoration(
            //hinText
            hintText: hintText,
            //prefixIcon
            prefixIcon: Icon(iconData, color: AppColor.yellowColor),
            // focusBorder
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.radius15),
                borderSide: BorderSide(width: 1.0, color: Colors.white)),
            // enabledBroder
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.radius15),
                borderSide: BorderSide(width: 1.0, color: Colors.white)),
            //broder
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.radius15),
                borderSide: BorderSide(width: 1.0, color: Colors.white)),

          )
      ),
    );
  }
}
