import 'package:flutter/material.dart';
import 'package:InventoryWise/utils/app_theme.dart';

class BoxButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Color? color;
  final bool isInverted;
  final IconData? icon;

  const BoxButton(
      {Key? key,
      this.title,
      this.onPressed,
      this.color,
      this.icon,
      this.isInverted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color != null
              ? color!
              : isInverted
                  ? Colors.white
                  : AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: isInverted ? AppTheme.primaryColor : Colors.white,
                  width: isInverted ? 1.5 : 0.0),
              borderRadius: BorderRadius.circular(10)),
          // padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          // textStyle: const TextStyle(
          // fontSize: 30,
          // fontWeight: FontWeight.bold)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: color != null
                    ? color!
                    : isInverted
                        ? AppTheme.primaryColor
                        : Colors.white,
                        // size: 22,
              ),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: isInverted ? AppTheme.primaryColor : Colors.white),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
