import 'package:flutter/material.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import '../ultis/dimensions.dart';
class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}
@override

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  double textHeight = Dimension.screenHeight / 5.63;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.length == "" ? Text(
            widget.text
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                flag ? firstHalf : widget.text
            ),
            const SizedBox(height: 5,),
            InkWell(
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
            ),

            Row(
              children: const [
                Text(
                    "Show more",
                    style: TextStyle(
                        color: AppColor.mainColor
                    )),
              ],
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppColor.mainColor,)
          ],
        )
    );
  }
}
