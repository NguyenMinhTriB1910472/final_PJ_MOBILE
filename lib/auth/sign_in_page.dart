import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grab_app_clone_2/auth/sign_up_page.dart';
import 'package:grab_app_clone_2/base/custom_loader.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';

import '../base/show_custom_snackbar.dart';
import '../controllers/auth_controller.dart';
import '../models/signup_body_model.dart';
import '../ultis/colors.dart';
import '../ultis/dimensions.dart';
import '../widgets/app_text_field.dart';
import '../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController) {
      var authController=Get.find<AuthController>();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email Address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password ", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than 6 characters ",
            title: "password");
      } else {
        showCustomSnackBar("All went well ", title: "Perfect");
        authController.login(phone,password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }

    }
    return Scaffold(
      backgroundColor: Colors.white,
      body:GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),

              Container(
                height: Dimension.screenHeight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage("assets/image/fooddelivery.gif"),
                  ),
                ),
              ),
              //welcome
              Container(
                margin: EdgeInsets.only(
                    left: Dimension.width20, right: Dimension.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimension.font20 * 3 + Dimension.font20 / 2,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        fontSize: Dimension.font20,
                        //fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimension.height20,),
              AppTextField(
                  textEditingController: phoneController,
                  hintText: "phone",
                  iconData: Icons.phone),
              SizedBox(
                height: Dimension.height20,
              ),
              AppTextField(
                textEditingController: passwordController,
                hintText: "Password",
                iconData: Icons.password_sharp,isObscure: true,),
              SizedBox(
                height: Dimension.height20,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  SizedBox(height: Dimension.height20,),
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimension.font20))),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                ],
              ),
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              //sign in
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimension.screenWidth / 2,
                  height: Dimension.screenHeight / 13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius30),
                      color: AppColor.mainColor),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimension.font20 + Dimension.font20 / 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              //tag line
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? ",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimension.font20),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignUpPage(),
                                  transition: Transition.fade),
                            text: "Create",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.mainBlackColor,
                                fontSize: Dimension.font20)),
                      ])),
            ],
          ),
        ):CustomLoader();
    },
    ));
  }
}
