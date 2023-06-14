import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:InventoryWise/utils/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    // this.focusNode,
    required this.text,
    this.isInverted = false,
    this.color,
    // this.fontSize,
    // this.fontWeight,
    this.onTap,
    // this.borderColor,
    // this.borderWidth = 0,
    // this.isBorder,
    this.buttonWidth,
    this.height,
    // this.borderRadius
  }) : super(key: key);

  // final FocusNode? focusNode;
  final String text;
  final bool isInverted;
  final Color? color;
  // final double fontSize;
  // final FontWeight fontWeight;
  final void Function()? onTap;
  // final Color borderColor;
  // final double borderWidth;
  final double? buttonWidth;
  // final bool isBorder;
  final double? height;
  // final double? borderRadius;

  // build method for UI rendering
  @override
  Widget build(BuildContext context) {
    return Container(

      height: height ?? 60,
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: isInverted
                  ? color != (null)
                      ? color!
                      : AppTheme.primaryColor
                  : Colors.white,
              width: isInverted ? 1.5 : 0.0),
          borderRadius: BorderRadius.circular(10.0),
          color: color != (null)
              ? color
              : isInverted
                  ? Colors.white
                  : AppTheme.primaryColor),
      child: MaterialButton(
          minWidth: buttonWidth != (null)
              ? buttonWidth
              : isInverted
                  ? Get.width * 0.74
                  : Get.width * 0.75,
                  
          // focusNode: widget.focusNode ?? widget.focusNode,
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                color: isInverted ? AppTheme.primaryColor : Colors.white),
          ),
          onPressed: onTap),
    );
  }
}
