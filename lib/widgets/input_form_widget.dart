import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class InputFormWidget extends StatefulWidget {
  const InputFormWidget({
    Key? key,
    this.controller,
    this.title,
    this.height,
    this.isInputPassword = false,
    this.isInputBlock = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? title;
  final double? height;
  final bool isInputPassword;
  final bool isInputBlock;

  @override
  _InputFormWidgetState createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  bool _isPasswordVisible = false;

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
              '${widget.title}',
              style: const TextStyle(color: black, fontSize: 15.0),
            ),
          ),
          Container(
            height: widget.height ?? 55.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: greyColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              controller: widget.controller,
              style: const TextStyle(color: black),
              obscureText: widget.isInputPassword && !_isPasswordVisible,
              maxLines: widget.isInputBlock ? null : 1,
              decoration: InputDecoration(
                hintText: '${widget.title}',
                border: InputBorder.none,
                labelStyle: const TextStyle(color: black),
                suffixIcon: widget.isInputPassword
                    ? IconButton(
                        icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _isPasswordVisible ? greyColor : redColor),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
