import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grab_app_clone_2/base/custom_loader.dart';
import 'package:grab_app_clone_2/base/show_custom_snackbar.dart';
import 'package:grab_app_clone_2/controllers/auth_controller.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'package:grab_app_clone_2/widgets/app_text_field.dart';
import 'package:grab_app_clone_2/widgets/big_text.dart';

import '../models/signup_body_model.dart';
import '../ultis/colors.dart';
import '../ultis/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = ['gg.png', 'fb.png', 'twitter.png'];
    void _registration(AuthController authController) {
      var authController=Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("Type in your name ", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number ", title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email Address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address ",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password ", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than 6 characters ",
            title: "password");
      } else {
        showCustomSnackBar("All went well ", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
        print(signUpBody.toString());
        authController.registraion(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }

    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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

              AppTextField(
                  textEditingController: emailController,
                  hintText: "Email",
                  iconData: Icons.email),
              SizedBox(
                height: Dimension.height20,
              ),
              AppTextField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  iconData: Icons.password_sharp,isObscure: true),
              SizedBox(
                height: Dimension.height20,
              ),
              AppTextField(
                  textEditingController: nameController,
                  hintText: "Name",
                  iconData: Icons.person),
              SizedBox(
                height: Dimension.height20,
              ),
              AppTextField(
                  textEditingController: phoneController,
                  hintText: "Phone",
                  iconData: Icons.phone),
              SizedBox(
                height: Dimension.height20,
              ),
              GestureDetector(
                onTap: () {
                  _registration(_authController);
                },
                child: Container(
                  width: Dimension.screenWidth / 2,
                  height: Dimension.screenHeight / 13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius30),
                      color: AppColor.mainColor),
                  child: Center(
                    child: BigText(
                      text: "Sign up",
                      size: Dimension.font20 + Dimension.font20 / 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimension.height10,
              ),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimension.font20))),
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              //tag line
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: "Sign up using one of the following methods",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font20 - Dimension.font20 / 5))),
              Wrap(
                children: List.generate(
                    3,
                        (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: Dimension.radius30,
                        backgroundImage:
                        AssetImage("/image/" + signUpImage[index]),
                      ),
                    )),
              )
            ],
          ),
        ):const CustomLoader();
      },
    ));
  }
}
