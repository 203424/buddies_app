import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class TextButtonAccountWidget extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final bool mostrarBorde;
  final bool redondearSuperior;
  final bool redondearInferior;
  final Color? colorText;

  const TextButtonAccountWidget({
    Key? key,
    required this.texto,
    required this.onPressed,
    this.mostrarBorde = true,
    this.redondearSuperior = true,
    this.redondearInferior = true,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: redondearSuperior ? const Radius.circular(10.0) : Radius.zero,
      topRight: redondearSuperior ? const Radius.circular(10.0) : Radius.zero,
      bottomLeft: redondearInferior ? const Radius.circular(10.0) : Radius.zero,
      bottomRight:
          redondearInferior ? const Radius.circular(10.0) : Radius.zero,
    );

    return Material(
      color: inputGrey,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: mostrarBorde
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: greyColor),
                  ),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(texto,
                style: Font.textStyleBold(
                    color: colorText ?? black, fontSize: 16.0)),
          ),
        ),
      ),
    );
  }
}
