import 'package:flutter/material.dart';

class ContactsListWidget extends StatelessWidget {
  final Widget? trailing;
  final ValueSetter<String> onTrailingTap;
  final IconData? trailingIcon;
  final List<String> listOfValues;
  const ContactsListWidget(
      {Key? key,
      required this.onTrailingTap,
      this.trailing,
      this.trailingIcon,
      required this.listOfValues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listOfValues.length,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              title: Text(
                listOfValues[index],
              ),
              trailing: trailing ??
                  IconButton(
                    alignment: Alignment.centerRight,
                    iconSize: 26,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      onTrailingTap(listOfValues[index]);
                    },
                    icon: Icon(trailingIcon),
                  ),
            ),
            index != listOfValues.length - 1
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      thickness: 1.2,
                      height: 0,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
