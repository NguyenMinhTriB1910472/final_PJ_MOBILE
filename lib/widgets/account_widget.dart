import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grab_app_clone_2/ultis/dimensions.dart';
import 'package:grab_app_clone_2/widgets/app_icon.dart';

import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: Dimension.width20,
          top: Dimension.width10,
          bottom: Dimension.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimension.width20,),
          bigText
        ],
      ),

    );
  }
}
