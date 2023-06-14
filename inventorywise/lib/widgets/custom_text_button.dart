import 'package:flutter/material.dart';
import 'package:InventoryWise/utils/app_theme.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isUnderLine = false,
      this.fontSize})
      : super(key: key);
  final String title;
  final Function()? onTap;
  final bool? isUnderLine;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(title,
          style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: fontSize,
              decoration: isUnderLine!
                  ? TextDecoration.underline
                  : TextDecoration.none)),
    );
  }
}
