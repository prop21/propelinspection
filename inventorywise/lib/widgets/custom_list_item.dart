import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem(
      {Key? key,
      this.leading,
      this.trailing,
      this.leadingIcon,
      this.trailingIcon,
      required this.title,
      this.subTitle,
      this.isThreeLine = false,
      this.leadingIconColor,
      this.titleColor,
      this.onTap})
      : super(
          key: key,
        );

  final String? title;
  final String? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final void Function()? onTap;
  final bool? isThreeLine;
  final Color? leadingIconColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListTile(
        isThreeLine: isThreeLine!,
        onTap: onTap,
        // ignore: prefer_if_null_operators
        leading: leading != null
            ? leading
            : leadingIcon != null
                ? Icon(
                    leadingIcon,
                    color: leadingIconColor,
                  )
                : null,
        title: Text(
          title!,
          style: TextStyle(
            color: titleColor,
          ),
        ),
        subtitle: subTitle == null ? null : Text(subTitle!),
        // ignore: prefer_if_null_operators
        trailing: trailing != null
            ? trailing
            : trailingIcon != null
                ? Icon(trailingIcon)
                : null,
      ),
    );
  }
}
