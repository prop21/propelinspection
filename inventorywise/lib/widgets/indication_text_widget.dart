import 'package:flutter/material.dart';

class IndicationTextWidget extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  IndicationTextWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "* ",
          style: TextStyle(color: Colors.grey),
        ),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.clip,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
