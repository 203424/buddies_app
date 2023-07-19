import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

import 'widgets/text_button_account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: TextButtonAccountWidget(
                  texto: "Quiero formar parte de Buddies",
                  onPressed: () {},
                  mostrarBorde: false,
                  redondearSuperior: true,
                  redondearInferior: true,
                ),
              )),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    "Perfil",
                    style: Font.titleStyle,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextButtonAccountWidget(
                      texto: "Mis datos",
                      onPressed: () {},
                      mostrarBorde: true,
                      redondearSuperior: true,
                      redondearInferior: false,
                    ),
                    TextButtonAccountWidget(
                      texto: "Cerrar sesión",
                      onPressed: () {},
                      mostrarBorde: true,
                      redondearSuperior: false,
                      redondearInferior: false,
                    ),
                    TextButtonAccountWidget(
                      texto: "Eliminar cuenta",
                      onPressed: () {},
                      colorText: redColor,
                      mostrarBorde: false,
                      redondearSuperior: false,
                      redondearInferior: true,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    "Sobre Buddies",
                    style: Font.titleStyle,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextButtonAccountWidget(
                      texto: "Centro de atención",
                      onPressed: () {},
                      mostrarBorde: true,
                      redondearSuperior: true,
                      redondearInferior: false,
                    ),
                    TextButtonAccountWidget(
                      texto: "Términos y condiciones",
                      onPressed: () {},
                      mostrarBorde: true,
                      redondearSuperior: false,
                      redondearInferior: false,
                    ),
                    TextButtonAccountWidget(
                      texto: "Aviso de privacidad",
                      onPressed: () {},
                      mostrarBorde: false,
                      redondearSuperior: false,
                      redondearInferior: true,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
