import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton({Key? key,
    this.onPressed,
    required this.buttonText,
    required this.transparent,
    this.margin, this.height,
    this.width,
    this.fontSize,
    this.radius =5,
    this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextButton.styleFrom(

    );
    return Container();
  }
}
