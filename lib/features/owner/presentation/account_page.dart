import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Perfil",
                style: Font.titleBoldStyle,
              ),
              IntrinsicHeight(
                child: Container(
                  color: inputGrey,
                  width: double.infinity,
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mis datos"),
                        Text("Cerrar sesión"),
                        Text("Eliminar cuenta")
                      ]),
                ),
              ),
              const Text(
                "Sobre Buddies",
                style: Font.titleBoldStyle,
              ),
              IntrinsicHeight(
                child: Container(
                  color: inputGrey,
                  width: double.infinity,
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Centro de atención"),
                        Text("Terminos y condiciones de uso"),
                        Text("Aviso de privacidad")
                      ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
