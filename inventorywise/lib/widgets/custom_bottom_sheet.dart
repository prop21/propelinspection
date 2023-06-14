import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final List<ListTileData> children;
  final double? height;
  const CustomBottomSheet({
    Key? key,
    this.height,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 8, left: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: ListView.builder(
        itemCount: children.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          leading: Icon(children[index].icon!),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: Text(children[index].text!),
          ),
          onTap: children[index].onTap,
        ),
      ),
    );
  }
}

class ListTileData {
  final IconData? icon;
  final String? text;
  final Function()? onTap;

  ListTileData({this.icon, this.text, this.onTap});
}
