import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({super.key, this.controller, this.title, this.height});

  final TextEditingController? controller;
  final String? title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              '$title',
              style: const TextStyle(color: black, fontSize: 15.0),
            ),
          ),
          Container(
            height: height ?? 55.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: greyColor),
                borderRadius: BorderRadius.circular(10.0)),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: black),
              decoration: InputDecoration(
                  hintText: '$title',
                  border: InputBorder.none,
                  labelStyle: const TextStyle(color: black)),
            ),
          ),
        ],
      ),
    );
  }
}
