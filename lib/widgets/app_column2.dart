
import 'package:flutter/material.dart';
import 'package:grab_app_clone_2/widgets/small_text.dart';
import '../ultis/colors.dart';
import '../ultis/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';
class AppColumn2 extends StatelessWidget {
  final String text;
  const AppColumn2({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,),
        // SizedBox(
        //   height: Dimension.height10,
        // ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => const Icon(
                    Icons.star,
                    color: AppColor.mainColor,
                    size: 15,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(
              text: "4.5",
              color: AppColor.mainBlackColor,
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: "1287", color: AppColor.mainBlackColor),
            const SizedBox(
              width: 10,
            ),
            SmallText(
                text: "comments", color: AppColor.mainBlackColor),
          ],
        ),
        SizedBox(
          height: Dimension.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              iconColor: AppColor.iconColor1,
              text: 'Normal',
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              iconColor: AppColor.mainColor,
              text: '1.7 km',
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              iconColor: AppColor.iconColor2,
              text: '32 min',
            )
          ],
        )
      ],
    );
  }
}
